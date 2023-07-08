// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class GetAllOrderedRoversUseCaseMock: @unchecked Sendable, GetAllOrderedRoversUseCase {

    //MARK: - execute

    var executeThrowableError: Error?
   public var executeCallsCount = 0
   public var executeCalled: Bool {
        return executeCallsCount > 0
    }
    public var executeReturnValue: [Rover]!
    public var executeClosure: (() throws -> [Rover])?

   public func execute() throws -> [Rover] {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        return try executeClosure.map({ try $0() }) ?? executeReturnValue
    }

}
