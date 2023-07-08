// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class SavePhotoUseCaseMock: @unchecked Sendable, SavePhotoUseCase {

    //MARK: - execute

   public var executeWithCallsCount = 0
   public var executeWithCalled: Bool {
        return executeWithCallsCount > 0
    }
    public var executeWithReceivedPhoto: Photo?
    public var executeWithReceivedInvocations: [Photo] = []
    public var executeWithClosure: ((Photo) -> Void)?

   public func execute(with photo: Photo) {
        executeWithCallsCount += 1
        executeWithReceivedPhoto = photo
        executeWithReceivedInvocations.append(photo)
        executeWithClosure?(photo)
    }

}
