// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import SOMDomainLayer
import Combine
import DomainInterfaces
import NasaModels
import UIKit

final class MarsPhotoStoringMock: MarsPhotoStoring {
    var getPersistedPhotos: CurrentValueSubject<[Photo], Never> {
        get { underlyingGetPersistedPhotos }
        set(value) { underlyingGetPersistedPhotos = value }
    }

    var underlyingGetPersistedPhotos: CurrentValueSubject<[Photo], Never>!

    // MARK: - save

    var saveCallsCount = 0
    var saveCalled: Bool {
        saveCallsCount > 0
    }

    var saveReceivedPhoto: Photo?
    var saveReceivedInvocations: [Photo] = []
    var saveClosure: ((Photo) -> Void)?

    func save(_ photo: Photo) {
        saveCallsCount += 1
        saveReceivedPhoto = photo
        saveReceivedInvocations.append(photo)
        saveClosure?(photo)
    }

    // MARK: - remove

    var removeCallsCount = 0
    var removeCalled: Bool {
        removeCallsCount > 0
    }

    var removeReceivedPhoto: Photo?
    var removeReceivedInvocations: [Photo] = []
    var removeClosure: ((Photo) -> Void)?

    func remove(_ photo: Photo) {
        removeCallsCount += 1
        removeReceivedPhoto = photo
        removeReceivedInvocations.append(photo)
        removeClosure?(photo)
    }

    // MARK: - persist

    var persistThrowableError: Error?
    var persistCallsCount = 0
    var persistCalled: Bool {
        persistCallsCount > 0
    }

    var persistClosure: (() throws -> Void)?

    func persist() throws {
        if let error = persistThrowableError {
            throw error
        }
        persistCallsCount += 1
        try persistClosure?()
    }

    // MARK: - clear

    var clearThrowableError: Error?
    var clearCallsCount = 0
    var clearCalled: Bool {
        clearCallsCount > 0
    }

    var clearClosure: (() throws -> Void)?

    func clear() throws {
        if let error = clearThrowableError {
            throw error
        }
        clearCallsCount += 1
        try clearClosure?()
    }
}
