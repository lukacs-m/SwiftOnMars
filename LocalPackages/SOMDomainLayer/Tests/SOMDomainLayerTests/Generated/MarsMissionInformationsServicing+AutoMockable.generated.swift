// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import SOMDomainLayer
import Combine
import DomainInterfaces
import NasaModels
import UIKit

final class MarsMissionInformationsServicingMock: MarsMissionInformationsServicing {
    // MARK: - getInformation

    var getInformationForThrowableError: Error?
    var getInformationForCallsCount = 0
    var getInformationForCalled: Bool {
        getInformationForCallsCount > 0
    }

    var getInformationForReceivedRover: RoverIdentification?
    var getInformationForReceivedInvocations: [RoverIdentification] = []
    var getInformationForReturnValue: Rover!
    var getInformationForClosure: ((RoverIdentification) throws -> Rover)?

    func getInformation(for rover: RoverIdentification) throws -> Rover {
        if let error = getInformationForThrowableError {
            throw error
        }
        getInformationForCallsCount += 1
        getInformationForReceivedRover = rover
        getInformationForReceivedInvocations.append(rover)
        return try getInformationForClosure.map { try $0(rover) } ?? getInformationForReturnValue
    }

    // MARK: - getManifest

    var getManifestForThrowableError: Error?
    var getManifestForCallsCount = 0
    var getManifestForCalled: Bool {
        getManifestForCallsCount > 0
    }

    var getManifestForReceivedRover: RoverIdentification?
    var getManifestForReceivedInvocations: [RoverIdentification] = []
    var getManifestForReturnValue: RoverManifest!
    var getManifestForClosure: ((RoverIdentification) throws -> RoverManifest)?

    func getManifest(for rover: RoverIdentification) throws -> RoverManifest {
        if let error = getManifestForThrowableError {
            throw error
        }
        getManifestForCallsCount += 1
        getManifestForReceivedRover = rover
        getManifestForReceivedInvocations.append(rover)
        return try getManifestForClosure.map { try $0(rover) } ?? getManifestForReturnValue
    }

    // MARK: - getPhotosByMartinSol

    var getPhotosByMartinSolForOnForAndThrowableError: Error?
    var getPhotosByMartinSolForOnForAndCallsCount = 0
    var getPhotosByMartinSolForOnForAndCalled: Bool {
        getPhotosByMartinSolForOnForAndCallsCount > 0
    }

    var getPhotosByMartinSolForOnForAndReceivedArguments: (rover: RoverIdentification, sol: Int, camera: String?,
                                                           page: Int?)?
    var getPhotosByMartinSolForOnForAndReceivedInvocations: [
        (rover: RoverIdentification, sol: Int, camera: String?,
         page: Int?)
    ] = []
    var getPhotosByMartinSolForOnForAndReturnValue: [Photo]!
    var getPhotosByMartinSolForOnForAndClosure: ((RoverIdentification, Int, String?, Int?) throws -> [Photo])?

    func getPhotosByMartinSol(for rover: RoverIdentification, on sol: Int, for camera: String?,
                              and page: Int?) throws -> [Photo] {
        if let error = getPhotosByMartinSolForOnForAndThrowableError {
            throw error
        }
        getPhotosByMartinSolForOnForAndCallsCount += 1
        getPhotosByMartinSolForOnForAndReceivedArguments = (rover: rover, sol: sol, camera: camera, page: page)
        getPhotosByMartinSolForOnForAndReceivedInvocations
            .append((rover: rover, sol: sol, camera: camera, page: page))
        return try getPhotosByMartinSolForOnForAndClosure
            .map { try $0(rover, sol, camera, page) } ?? getPhotosByMartinSolForOnForAndReturnValue
    }

    // MARK: - getPhotosByDate

    var getPhotosByDateForAtForAndThrowableError: Error?
    var getPhotosByDateForAtForAndCallsCount = 0
    var getPhotosByDateForAtForAndCalled: Bool {
        getPhotosByDateForAtForAndCallsCount > 0
    }

    var getPhotosByDateForAtForAndReceivedArguments: (rover: RoverIdentification, date: String, camera: String?,
                                                      page: Int?)?
    var getPhotosByDateForAtForAndReceivedInvocations: [(rover: RoverIdentification, date: String, camera: String?,
                                                         page: Int?)] = []
    var getPhotosByDateForAtForAndReturnValue: [Photo]!
    var getPhotosByDateForAtForAndClosure: ((RoverIdentification, String, String?, Int?) throws -> [Photo])?

    func getPhotosByDate(for rover: RoverIdentification, at date: String, for camera: String?,
                         and page: Int?) throws -> [Photo] {
        if let error = getPhotosByDateForAtForAndThrowableError {
            throw error
        }
        getPhotosByDateForAtForAndCallsCount += 1
        getPhotosByDateForAtForAndReceivedArguments = (rover: rover, date: date, camera: camera, page: page)
        getPhotosByDateForAtForAndReceivedInvocations
            .append((rover: rover, date: date, camera: camera, page: page))
        return try getPhotosByDateForAtForAndClosure
            .map { try $0(rover, date, camera, page) } ?? getPhotosByDateForAtForAndReturnValue
    }
}
