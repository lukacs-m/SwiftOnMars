// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class GetCurrentSearchParametersUseCaseMock: @unchecked Sendable, GetCurrentSearchParametersUseCase {

    //MARK: - execute

   public var executeCallsCount = 0
   public var executeCalled: Bool {
        return executeCallsCount > 0
    }
    public var executeReturnValue: SearchParameters!
    public var executeClosure: (() -> SearchParameters)?

   public func execute() -> SearchParameters {
        executeCallsCount += 1
        return executeClosure.map({ $0() }) ?? executeReturnValue
    }

    //MARK: - executePublisher

   public var executePublisherCallsCount = 0
   public var executePublisherCalled: Bool {
        return executePublisherCallsCount > 0
    }
    public var executePublisherReturnValue: CurrentValueSubject<SearchParameters, Never>!
    public var executePublisherClosure: (() -> CurrentValueSubject<SearchParameters, Never>)?

   public func executePublisher() -> CurrentValueSubject<SearchParameters, Never> {
        executePublisherCallsCount += 1
        return executePublisherClosure.map({ $0() }) ?? executePublisherReturnValue
    }

}
