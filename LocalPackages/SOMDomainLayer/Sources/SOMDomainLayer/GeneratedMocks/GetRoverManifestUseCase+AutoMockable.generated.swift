// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class GetRoverManifestUseCaseMock: @unchecked Sendable, GetRoverManifestUseCase {

    //MARK: - execute

    var executeForThrowableError: Error?
   public var executeForCallsCount = 0
   public var executeForCalled: Bool {
        return executeForCallsCount > 0
    }
    public var executeForReceivedRoverId: RoverIdentification?
    public var executeForReceivedInvocations: [RoverIdentification] = []
    public var executeForReturnValue: RoverManifest!
    public var executeForClosure: ((RoverIdentification) throws -> RoverManifest)?

   public func execute(for roverId: RoverIdentification) throws -> RoverManifest {
        if let error = executeForThrowableError {
            throw error
        }
        executeForCallsCount += 1
        executeForReceivedRoverId = roverId
        executeForReceivedInvocations.append(roverId)
        return try executeForClosure.map({ try $0(roverId) }) ?? executeForReturnValue
    }

}
