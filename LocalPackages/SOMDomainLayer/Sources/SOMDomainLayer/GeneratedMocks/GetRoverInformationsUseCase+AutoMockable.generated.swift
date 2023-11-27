// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import DomainInterfaces
import NasaModels
import UIKit

public final class GetRoverInformationsUseCaseMock: @unchecked Sendable, GetRoverInformationsUseCase {
    // MARK: - execute

    var executeForThrowableError: (any Error)?
    public var executeForCallsCount = 0
    public var executeForCalled: Bool {
        executeForCallsCount > 0
    }

    public var executeForReceivedRoverId: RoverIdentification?
    public var executeForReceivedInvocations: [RoverIdentification] = []
    public var executeForReturnValue: Rover!
    public var executeForClosure: ((RoverIdentification) throws -> Rover)?

    public func execute(for roverId: RoverIdentification) throws -> Rover {
        if let error = executeForThrowableError {
            throw error
        }
        executeForCallsCount += 1
        executeForReceivedRoverId = roverId
        executeForReceivedInvocations.append(roverId)
        return try executeForClosure.map { try $0(roverId) } ?? executeForReturnValue
    }
}
