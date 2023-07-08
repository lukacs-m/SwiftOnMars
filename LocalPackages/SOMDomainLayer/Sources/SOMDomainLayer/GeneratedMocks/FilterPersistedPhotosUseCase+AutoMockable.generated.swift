// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class FilterPersistedPhotosUseCaseMock: @unchecked Sendable, FilterPersistedPhotosUseCase {

    //MARK: - execute

   public var executeForCallsCount = 0
   public var executeForCalled: Bool {
        return executeForCallsCount > 0
    }
    public var executeForReceivedFilterSelection: PhotoFilterSelection?
    public var executeForReceivedInvocations: [PhotoFilterSelection] = []
    public var executeForReturnValue: AnyPublisher<[String:[Photo]], Never>!
    public var executeForClosure: ((PhotoFilterSelection) -> AnyPublisher<[Photo], Never>)?

    public func execute(for filterSelection: PhotoFilterSelection) -> AnyPublisher<[String:[Photo]], Never> {
        executeForCallsCount += 1
        executeForReceivedFilterSelection = filterSelection
        executeForReceivedInvocations.append(filterSelection)
        return executeForReturnValue //executeForClosure.map({ $0(filterSelection) }) ?? executeForReturnValue
    }

}
