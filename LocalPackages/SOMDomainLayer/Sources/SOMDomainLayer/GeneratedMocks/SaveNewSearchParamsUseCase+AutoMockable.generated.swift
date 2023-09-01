// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import DomainInterfaces
import NasaModels
import UIKit

public final class SaveNewSearchParamsUseCaseMock: @unchecked Sendable, SaveNewSearchParamsUseCase {
    // MARK: - execute

    public var executeWithCallsCount = 0
    public var executeWithCalled: Bool {
        executeWithCallsCount > 0
    }

    public var executeWithReceivedParams: SearchParameters?
    public var executeWithReceivedInvocations: [SearchParameters] = []
    public var executeWithClosure: ((SearchParameters) -> Void)?

    public func execute(with params: SearchParameters) {
        executeWithCallsCount += 1
        executeWithReceivedParams = params
        executeWithReceivedInvocations.append(params)
        executeWithClosure?(params)
    }
}
