//
//  MarsMissionInformationsServicing.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

import Foundation
import NasaModels

public protocol MarsMissionInformationsServicing: Sendable {
    /// Informations of the requested rover
    /// - Parameter rover: The name indentification for the `Rover`
    /// - Returns: A `Rover` containg informations of the slected rover
    func getInformation(for rover: RoverIdentification) async throws -> Rover

    /// Informations of the requested rover
    /// - Parameter rover: The name indentification for the `Rover`
    /// - Returns: A `Rover manifest` containg informations for all the photos link to the rover
    func getManifest(for rover: RoverIdentification) async throws -> RoverManifest

    ///  Fetches all photos for a specific rover and martian sol
    /// - Parameters:
    ///   - rover: The name id of the rover
    ///   - sol: The number of days since the landing of the rover on mars
    ///   - camera: The selected camera of the rover.  By default this will represent all cameras
    ///   - page: The page number of queried photos. If it is set it creates a pagination of 25 photos per page
    /// - Returns: An array of  mars `Photo` taken by the selected rover.
    func getPhotosByMartinSol(for rover: RoverIdentification,
                              on sol: Int,
                              for camera: String?,
                              and page: Int?) async throws -> [Photo]

    /// Fetches all photos for a specific rover for a specific date
    /// - Parameters:
    ///   - rover: The name id of the rover
    ///   - date: The eath date for the photos. This should have the following format `YYYY-MM-DD`. Example: 2019-6-3
    ///   - camera: The selected camera of the rover.  By default this will represent all cameras
    ///   - page: If set create a pagination of 25 photos per page
    /// - Returns:  The page number of queried photos. If it is set it creates a pagination of 25 photos per page
    func getPhotosByDate(for rover: RoverIdentification,
                              at date: String,
                              for camera: String?,
                              and page: Int?) async throws -> [Photo]

}
