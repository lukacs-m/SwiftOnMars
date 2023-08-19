// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import DomainInterfaces
import NasaModels
import UIKit

public final class RemovePersistedPhotoUseCaseMock: @unchecked Sendable, RemovePersistedPhotoUseCase {
    // MARK: - execute

    public var executeForCallsCount = 0
    public var executeForCalled: Bool {
        executeForCallsCount > 0
    }

    public var executeForReceivedPhoto: Photo?
    public var executeForReceivedInvocations: [Photo] = []
    public var executeForClosure: ((Photo) -> Void)?

    public func execute(for photo: Photo) {
        executeForCallsCount += 1
        executeForReceivedPhoto = photo
        executeForReceivedInvocations.append(photo)
        executeForClosure?(photo)
    }
}
