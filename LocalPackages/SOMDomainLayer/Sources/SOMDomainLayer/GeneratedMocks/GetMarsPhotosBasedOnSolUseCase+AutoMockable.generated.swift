// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import DomainInterfaces
import NasaModels
import UIKit

public final class GetMarsPhotosBasedOnSolUseCaseMock: @unchecked Sendable, GetMarsPhotosBasedOnSolUseCase {
    // MARK: - execute

    var executeForAtForAndThrowableError: Error?
    public var executeForAtForAndCallsCount = 0
    public var executeForAtForAndCalled: Bool {
        executeForAtForAndCallsCount > 0
    }

    public var executeForAtForAndReceivedArguments: (roverId: RoverIdentification, sol: Int, camera: String?,
                                                     page: Int?)?
    public var executeForAtForAndReceivedInvocations: [(roverId: RoverIdentification, sol: Int, camera: String?,
                                                        page: Int?)] = []
    public var executeForAtForAndReturnValue: [Photo]!
    public var executeForAtForAndClosure: ((RoverIdentification, Int, String?, Int?) throws -> [Photo])?

    public func execute(for roverId: RoverIdentification, at sol: Int, for camera: String?,
                        and page: Int?) throws -> [Photo] {
        if let error = executeForAtForAndThrowableError {
            throw error
        }
        executeForAtForAndCallsCount += 1
        executeForAtForAndReceivedArguments = (roverId: roverId, sol: sol, camera: camera, page: page)
        executeForAtForAndReceivedInvocations.append((roverId: roverId, sol: sol, camera: camera, page: page))
        return try executeForAtForAndClosure
            .map { try $0(roverId, sol, camera, page) } ?? executeForAtForAndReturnValue
    }
}
