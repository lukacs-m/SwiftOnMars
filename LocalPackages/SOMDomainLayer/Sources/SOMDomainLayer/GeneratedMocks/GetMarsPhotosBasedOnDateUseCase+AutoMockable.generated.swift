// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import DomainInterfaces
import NasaModels
import UIKit

public final class GetMarsPhotosBasedOnDateUseCaseMock: @unchecked Sendable, GetMarsPhotosBasedOnDateUseCase {
    // MARK: - execute

    var executeForAtForAndThrowableError: (any Error)?
    public var executeForAtForAndCallsCount = 0
    public var executeForAtForAndCalled: Bool {
        executeForAtForAndCallsCount > 0
    }

    public var executeForAtForAndReceivedArguments: (roverId: RoverIdentification, date: String, camera: String?,
                                                     page: Int?)?
    public var executeForAtForAndReceivedInvocations: [
        (roverId: RoverIdentification, date: String, camera: String?,
         page: Int?)
    ] = []
    public var executeForAtForAndReturnValue: [Photo]!
    public var executeForAtForAndClosure: ((RoverIdentification, String, String?, Int?) throws -> [Photo])?

    public func execute(for roverId: RoverIdentification, at date: String, for camera: String?,
                        and page: Int?) throws -> [Photo] {
        if let error = executeForAtForAndThrowableError {
            throw error
        }
        executeForAtForAndCallsCount += 1
        executeForAtForAndReceivedArguments = (roverId: roverId, date: date, camera: camera, page: page)
        executeForAtForAndReceivedInvocations.append((roverId: roverId, date: date, camera: camera, page: page))
        return try executeForAtForAndClosure
            .map { try $0(roverId, date, camera, page) } ?? executeForAtForAndReturnValue
    }
}
