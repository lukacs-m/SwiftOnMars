// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces

public final class CheckIfPhotoIsPersistedUseCaseMock: @unchecked Sendable, CheckIfPhotoIsPersistedUseCase {

    //MARK: - execute

   public var executeForCallsCount = 0
   public var executeForCalled: Bool {
        return executeForCallsCount > 0
    }
    public var executeForReceivedPhoto: Photo?
    public var executeForReceivedInvocations: [Photo] = []
    public var executeForReturnValue: Bool!
    public var executeForClosure: ((Photo) -> Bool)?

   public func execute(for photo: Photo) -> Bool {
        executeForCallsCount += 1
        executeForReceivedPhoto = photo
        executeForReceivedInvocations.append(photo)
        return executeForClosure.map({ $0(photo) }) ?? executeForReturnValue
    }

}
