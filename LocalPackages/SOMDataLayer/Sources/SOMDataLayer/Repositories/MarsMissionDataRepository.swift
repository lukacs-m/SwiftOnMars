//
//  MarsMissionDataRepository.swift
//
//
//  Created by Martin Lukacs on 10/04/2023.
//

import DomainInterfaces
import Foundation
import NasaModels
import SafeCache
import SimpleNetwork
@_exported import SimplyPersist
import SwiftData

@preconcurrency import Combine

public actor MarsMissionDataRepository: MarsMissionInformationsServicing {
    private let networkClient: any SimpleClient
    private let persistantStorage: any PersistenceServicing
    private let photoCache: any SafePersistantCaching<Int, Photos>
    private let roverCache: any SafePersistantCaching<String, Rover>
    private let manifestCache: any SafePersistantCaching<String, RoverManifest>

    private var photoActiveTasks: [Int: Task<Photos, any Error>] = [:]
    private var manifestActiveTasks: [String: Task<RoverManifest, any Error>] = [:]
    private var roverActiveTasks: [String: Task<Rover, any Error>] = [:]

    public let getPersistedPhotos: CurrentValueSubject<[Photo], Never> = .init([])

    public init(networkClient: any SimpleClient = SimpleNetworkClient(),
                persistantStorage: any PersistenceServicing,
                photoCache: any SafePersistantCaching<Int, Photos> = SafeCache<Int, Photos>(),
                roverCache: any SafePersistantCaching<String, Rover> = SafeCache<String, Rover>(),
                manifestCache: any SafePersistantCaching<String, RoverManifest> = SafeCache<String,
                    RoverManifest>()) {
        self.networkClient = networkClient
        self.photoCache = photoCache
        self.roverCache = roverCache
        self.manifestCache = manifestCache
        self.persistantStorage = persistantStorage
        setUp()
    }
}

// MARK: - Rover

public extension MarsMissionDataRepository {
    func getInformation(for rover: RoverIdentification) async throws -> Rover {
        if let existingTask = roverActiveTasks[rover.rawValue] {
            return try await existingTask.value
        }

        let task = Task<Rover, any Error> {
            if let cachedRover = await roverCache.value(forKey: rover.rawValue) {
                roverActiveTasks[rover.rawValue] = nil
                return cachedRover
            }

            do {
                let infos: RoverInfos = try await networkClient.request(endpoint: MarsMissionEndpoint.rover(id: rover.rawValue))
                await roverCache.insert(infos.rover, forKey: rover.rawValue)
                roverActiveTasks[rover.rawValue] = nil
                return infos.rover
            } catch {
                roverActiveTasks[rover.rawValue] = nil
                throw error
            }
        }

        roverActiveTasks[rover.rawValue] = task

        return try await task.value
    }
}

// MARK: - Manifest

public extension MarsMissionDataRepository {
    func getManifest(for rover: RoverIdentification) async throws -> RoverManifest {
        if let existingTask = manifestActiveTasks[rover.rawValue] {
            return try await existingTask.value
        }

        let task = Task<RoverManifest, any Error> {
            if let cachedManifest = await manifestCache.value(forKey: rover.rawValue) {
                manifestActiveTasks[rover.rawValue] = nil
                return cachedManifest
            }

            do {
                let manifest: RoverManifest = try await networkClient
                    .request(endpoint: MarsMissionEndpoint.manifest(id: rover.rawValue))
                await manifestCache.insert(manifest, forKey: rover.rawValue)
                manifestActiveTasks[rover.rawValue] = nil
                return manifest
            } catch {
                manifestActiveTasks[rover.rawValue] = nil
                throw error
            }
        }

        manifestActiveTasks[rover.rawValue] = task

        return try await task.value
    }
}

// MARK: - Photos

public extension MarsMissionDataRepository {
    func getPhotosByMartinSol(for rover: RoverIdentification,
                              on sol: Int,
                              for camera: String?,
                              and page: Int?) async throws -> [Photo] {
        let requestParams = RequestParams(roverId: rover.rawValue, sol: sol, date: nil, camera: camera,
                                          page: page)
        return try await fetchRequest(for: requestParams)
    }

    func getPhotosByDate(for rover: RoverIdentification,
                         at date: String,
                         for camera: String?,
                         and page: Int?) async throws -> [Photo] {
        let requestParams = RequestParams(roverId: rover.rawValue, sol: nil, date: date, camera: camera,
                                          page: page)
        return try await fetchRequest(for: requestParams)
    }
}

extension MarsMissionDataRepository: MarsPhotoStoring {
    public func clear() async throws {
        try await persistantStorage.deleteAll(dataTypes: [PhotoEntity.self])
    }

    public func save(_ photo: Photo) async {
        try? await persistantStorage.save(data: photo.toEntity)
        await update()
    }

    public func remove(_ photo: Photo) async {
        let id = photo.id
        let predicate = #Predicate<PhotoEntity> { entity in
            entity.id == id
        }
        guard let entity: PhotoEntity = try? await persistantStorage.fetchOne(predicate: predicate) else {
            return
        }
        try? await persistantStorage.delete(element: entity)
        await update()
    }

    private func update() async {
        guard let currentPhotos: [PhotoEntity] = try? await persistantStorage.fetchAll() else {
            return
        }
        getPersistedPhotos.send(currentPhotos.toPhotos)
    }
}

private extension MarsMissionDataRepository {
    nonisolated func setUp() {
        Task { [weak self] in
            guard let self else {
                return
            }
            guard let photos: [PhotoEntity] = try? await persistantStorage.fetchAll() else {
                return
            }
            getPersistedPhotos.send(photos.toPhotos)
        }
    }

    func fetchRequest(for requestParams: RequestParams) async throws -> [Photo] {
        if let existingTask = photoActiveTasks[requestParams.hashValue] {
            return try await existingTask.value.photos
        }

        let task = Task<Photos, any Error> {
            if let cachedPhotos = await photoCache.value(forKey: requestParams.hashValue) {
                photoActiveTasks[requestParams.hashValue] = nil
                return cachedPhotos
            }

            do {
                let endpoint = requestParams.sol != nil ? MarsMissionEndpoint
                    .photoWithSol(request: requestParams) : MarsMissionEndpoint.photoFromDate(request: requestParams)
                let photos: Photos = try await networkClient.request(endpoint: endpoint)
                await photoCache.insert(photos, forKey: requestParams.hashValue)
                photoActiveTasks[requestParams.hashValue] = nil
                return photos
            } catch {
                photoActiveTasks[requestParams.hashValue] = nil
                throw error
            }
        }

        photoActiveTasks[requestParams.hashValue] = task

        return try await task.value.photos
    }
}
