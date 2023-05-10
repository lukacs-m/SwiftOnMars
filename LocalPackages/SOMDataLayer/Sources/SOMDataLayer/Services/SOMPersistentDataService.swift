//
//  SOMPersistentDataService.swift
//  
//
//  Created by Martin Lukacs on 12/04/2023.
//

import Foundation
import SimplySave

public protocol NasaMissionPersitentDataServicing<Value>: Actor {
    associatedtype Value: Codable & Identifiable & Sendable

    func add(with newElement: Value)
    func remove(with element: Value)
    func getCurrentContent() -> [Value]
    func load() async throws -> [Value]
    func persistData() async throws
    func clear() async throws
}

public enum PersistenceError: Swift.Error {
    case fileAlreadyExist
    case invalidDirectory
    case writtingFailed
    case fileDoesNotExist
    case readingDataFailed
}

public actor SOMPersistentDataService<Value: Codable & Sendable & Identifiable>: NasaMissionPersitentDataServicing {

    private var currentData = [Value]()
    let storageManager: SimpleSaving
    private  let containerName = "missions.json"

    public init(storageManager: SimpleSaving = SimplySaveClient()) {
        self.storageManager = storageManager
    }
}

public extension SOMPersistentDataService {
    func getCurrentContent() -> [Value] {
        currentData
    }

    func add(with newElement: Value) {
        currentData.append(newElement)
    }

    func remove(with element: Value) {
        currentData.removeAll { $0.id == element.id }
    }

    func persistData() async throws {
        try await clear()
        try await storageManager.save(currentData, as: containerName, in: .documents)
    }

    func load() async throws -> [Value] {
        let values: [Value] = try await storageManager.fetch(from: containerName, in: .documents)

        currentData.append(contentsOf: values)
        return currentData
    }

    func clear() async throws {
        try await storageManager.remove(containerName, from: .documents)
    }
}
