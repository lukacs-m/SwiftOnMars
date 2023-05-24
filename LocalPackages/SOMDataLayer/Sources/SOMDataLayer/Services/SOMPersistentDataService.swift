//
//  SOMPersistentDataService.swift
//  
//
//  Created by Martin Lukacs on 12/04/2023.
//

import Foundation
import SimplySave

public protocol NasaMissionPersitentDataServicing<Value>: Actor, Sendable {
    associatedtype Value: Codable & Identifiable & Sendable

    func add(with newElement: Value)
    func remove(with element: Value)
    func getCurrentContent() -> [Value]
    func load() async throws -> [Value]
    func persistData() async throws
    func clear() async throws
}

public enum PersistenceError: Error {
    case fileAlreadyExist
    case invalidDirectory
    case writtingFailed
    case fileDoesNotExist
    case readingDataFailed
}

public actor SOMPersistentDataService<Value: Codable & Sendable & Identifiable>: NasaMissionPersitentDataServicing {
    private var currentData = [Value]()
    private let storageManager: SimpleSaving
    private let containerName = "missions.json"
    private var hasNewChanges = false

    public init(storageManager: SimpleSaving = SimplySaveClient()) {
        self.storageManager = storageManager

    }
}

public extension SOMPersistentDataService {
    func getCurrentContent() -> [Value] {
        currentData
    }

    func add(with newElement: Value) {
        hasNewChanges = true
        currentData.append(newElement)
    }

    func remove(with element: Value) {
        hasNewChanges = true
        currentData.removeAll { $0.id == element.id }
    }

    func persistData() async throws {
        guard hasNewChanges else {
            return
        }
        try await clear()
        try await storageManager.save(currentData, as: containerName, in: .documents)
        hasNewChanges = false
    }

    func load() async throws -> [Value] {
        let values: [Value] = try await storageManager.fetch(from: containerName, in: .documents)

        currentData.append(contentsOf: values)
        return currentData
    }

    func clear() async throws {
        let exists = await storageManager.exists(containerName, in: .documents)
        guard exists else {
            return
        }
        try await storageManager.remove(containerName, from: .documents)
    }
}
