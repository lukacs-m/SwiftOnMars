//
//  
//  GetPhotosForSearchParams.swift
//  
//
//  Created by Martin Lukacs on 19/08/2023.
//
//

import NasaModels
import Foundation

public protocol GetPhotosForSearchParamsUseCase: Sendable {
    func execute(for searchParameters: SearchParameters, and pageOffset: Int) async throws -> [Photo]
}

public extension GetPhotosForSearchParamsUseCase {
    func callAsFunction(for searchParameters: SearchParameters, and pageOffset: Int) async throws -> [Photo] {
        try await execute(for: searchParameters, and: pageOffset)
    }
}

public final class GetPhotosForSearchParams: GetPhotosForSearchParamsUseCase {
    private let marsPhotoSolUsecase: any GetMarsPhotosBasedOnSolUseCase
    private let marsPhotoDateUsecase: any GetMarsPhotosBasedOnDateUseCase

    public init(marsPhotoSolUsecase: any GetMarsPhotosBasedOnSolUseCase,
         marsPhotoDateUsecase: any GetMarsPhotosBasedOnDateUseCase) {
        self.marsPhotoSolUsecase = marsPhotoSolUsecase
        self.marsPhotoDateUsecase = marsPhotoDateUsecase
    }
    
    public func execute(for searchParameters: SearchParameters, and pageOffset: Int) async throws -> [Photo] {
        searchParameters.searchBySol ?
        try await marsPhotoSolUsecase(for: searchParameters.roverId,
                                      at: searchParameters.sol,
                                      for: searchParameters.camera,
                                      and: pageOffset) :
        try await marsPhotoDateUsecase(for: searchParameters.roverId,
                                       at: getStringDate(date: searchParameters.earthDate ?? Date()),
                                       for: searchParameters.camera,
                                       and: pageOffset)
    }
}

private extension GetPhotosForSearchParams {
    func getStringDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return  dateFormatter.string(from: date)
    }
}

