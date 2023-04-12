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

public actor MarsMissionDataRepository: MarsMissionInformationsServicing {
    private let networkClient: SimpleClient
    private let cache: any SafePersistantCaching<Int, Photos>

    public init(networkClient: SimpleClient = SimpleNetworkClient(),
         cache: any SafePersistantCaching<Int, Photos> = SafeCache<Int, Photos>()) {
        self.networkClient = networkClient
        self.cache = cache
    }

    public func getInformation(for rover: RoverIdentification) async throws -> Rover {
        try await networkClient.request(endpoint: MarsMissionEndpoint.rover(id: rover.rawValue))
    }

    public func getPhotosByMartinSol(for rover: RoverIdentification,
                              on sol: Int,
                              for camera: String?,
                              and page: Int?) async throws -> [Photo] {
        do {
            let requestParams = RequestParams(roverId: rover.rawValue, sol: sol, date: nil, camera: camera, page: page)
            return try await fetchRequest(for: requestParams)
        } catch {
            throw error
        }
    }

    public func getPhotosByDate(for rover: RoverIdentification,
                         at date: String,
                         for camera: String?,
                         and page: Int?) async throws -> [Photo] {
        do {
            let requestParams = RequestParams(roverId: rover.rawValue, sol: nil, date: date, camera: camera, page: page)
            return try await fetchRequest(for: requestParams)
        } catch {
            throw error
        }
    }
}

private extension MarsMissionDataRepository {
    func fetchRequest(for requestParams: RequestParams) async throws -> [Photo] {
        if let cachedPhotos = await cache.value(forKey: requestParams.hashValue) {
            return cachedPhotos.photos
        }
        let photos: Photos = try await networkClient.request(endpoint: MarsMissionEndpoint.photoFromDate(request: requestParams))
        await cache.insert(photos, forKey: requestParams.hashValue)

        return photos.photos
    }
}
