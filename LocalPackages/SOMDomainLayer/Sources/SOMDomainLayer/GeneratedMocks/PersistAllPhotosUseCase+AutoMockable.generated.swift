// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class PersistAllPhotosUseCaseMock: @unchecked Sendable, PersistAllPhotosUseCase {

    //MARK: - execute

    var executeThrowableError: Error?
   public var executeCallsCount = 0
   public var executeCalled: Bool {
        return executeCallsCount > 0
    }
    public var executeClosure: (() throws -> Void)?

   public func execute() throws {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        try executeClosure?()
    }

}
