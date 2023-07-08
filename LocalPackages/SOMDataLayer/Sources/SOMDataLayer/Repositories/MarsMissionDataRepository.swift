//
//  File.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

import NasaModels
import DomainInterfaces
import SimpleNetwork
import SafeCache
@preconcurrency import Combine

public actor MarsMissionDataRepository: MarsMissionInformationsServicing {
    private let networkClient: SimpleClient
    private let persistantStorage: any NasaMissionPersitentDataServicing<Photo>
    private let photoCache: any SafePersistantCaching<Int, Photos>
    private let roverCache: any SafePersistantCaching<String, Rover>
    private let manifestCache: any SafePersistantCaching<String, RoverManifest>

    public let getPersistedPhotos: CurrentValueSubject<[Photo], Never> = .init([])

    public init(networkClient: SimpleClient = SimpleNetworkClient(),
                persistantStorage: any NasaMissionPersitentDataServicing<Photo> = SOMPersistentDataService(),
                photoCache: any SafePersistantCaching<Int, Photos> = SafeCache<Int, Photos>(),
                roverCache: any SafePersistantCaching<String, Rover> = SafeCache<String, Rover>(),
                manifestCache: any SafePersistantCaching<String, RoverManifest> = SafeCache<String, RoverManifest>()) {
        self.networkClient = networkClient
        self.photoCache = photoCache
        self.roverCache = roverCache
        self.manifestCache = manifestCache
        self.persistantStorage = persistantStorage
        Task {
           await setUp()
        }
    }

    public func getInformation(for rover: RoverIdentification) async throws -> Rover {
            if let cachedRover = await roverCache.value(forKey: rover.rawValue) {
                return cachedRover
            }
            let infos: RoverInfos =  try await networkClient.request(endpoint: MarsMissionEndpoint.rover(id: rover.rawValue))
            await roverCache.insert(infos.rover, forKey: rover.rawValue)
            return infos.rover
    }

    public func getManifest(for rover: RoverIdentification) async throws -> RoverManifest {
            if let cachedManifest = await manifestCache.value(forKey: rover.rawValue) {
                return cachedManifest
            }
            let manifest: RoverManifest = try await networkClient.request(endpoint: MarsMissionEndpoint.manifest(id: rover.rawValue))
            await manifestCache.insert(manifest, forKey: rover.rawValue)
            return manifest
    }

    public func getPhotosByMartinSol(for rover: RoverIdentification,
                              on sol: Int,
                              for camera: String?,
                              and page: Int?) async throws -> [Photo] {
            let requestParams = RequestParams(roverId: rover.rawValue, sol: sol, date: nil, camera: camera, page: page)
            return try await fetchRequest(for: requestParams)
    }

    public func getPhotosByDate(for rover: RoverIdentification,
                         at date: String,
                         for camera: String?,
                         and page: Int?) async throws -> [Photo] {
            let requestParams = RequestParams(roverId: rover.rawValue, sol: nil, date: date, camera: camera, page: page)
            return try await fetchRequest(for: requestParams)

    }
}

extension MarsMissionDataRepository: MarsPhotoStoring {
    public func persist() async throws {
       try await persistantStorage.persistData()
    }

    public func clear() async throws {
        try await persistantStorage.clear()
    }

    public func save(_ photo: Photo) async {
        await persistantStorage.add(with: photo)
        update()
    }

    public func remove(_ photo: Photo) async {
        await persistantStorage.remove(with: photo)
        update()
    }

    private func update() {
        Task { [weak self] in
            guard let self else {
                return
            }
            let currentPhotos = await self.persistantStorage.getCurrentContent()
            self.getPersistedPhotos.send(currentPhotos)
        }
    }
}

private extension MarsMissionDataRepository {
    func setUp() async {
        guard let photos = try? await persistantStorage.load() else {
            return
        }
        getPersistedPhotos.send(photos)
    }

    func fetchRequest(for requestParams: RequestParams) async throws -> [Photo] {
        if let cachedPhotos = await photoCache.value(forKey: requestParams.hashValue) {
            return cachedPhotos.photos
        }
        let endpoint = requestParams.sol != nil ? MarsMissionEndpoint.photoWithSol(request: requestParams) : MarsMissionEndpoint.photoFromDate(request: requestParams)
        let photos: Photos = try await networkClient.request(endpoint: endpoint)
        await photoCache.insert(photos, forKey: requestParams.hashValue)

        return photos.photos
    }
}
