// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class GetPersistedPhotosUseCaseMock: @unchecked Sendable, GetPersistedPhotosUseCase {

    //MARK: - execute

   public var executeCallsCount = 0
   public var executeCalled: Bool {
        return executeCallsCount > 0
    }
    public var executeReturnValue: AnyPublisher<[Photo], Never>!
    public var executeClosure: (() -> AnyPublisher<[Photo], Never>)?

   public func execute() -> AnyPublisher<[Photo], Never> {
        executeCallsCount += 1
        return executeClosure.map({ $0() }) ?? executeReturnValue
    }

}
