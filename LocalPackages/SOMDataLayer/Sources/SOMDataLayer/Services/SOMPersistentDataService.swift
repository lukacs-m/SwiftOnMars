//
//  SOMPersistentDataService.swift
//  
//
//  Created by Martin Lukacs on 12/04/2023.
//

import Foundation

public protocol NasaMissionPersitentDataServicing<Value>: Actor {
    associatedtype Value: Codable & Identifiable

    func add(with newElement: Value)
    func remove(with element: Value)
    func getCurrentContent() -> [Value]
    func load(from fileNamed: String) throws
    func save(with fileName: String) throws
}

public enum PersistenceError: Swift.Error {
    case fileAlreadyExist
    case invalidDirectory
    case writtingFailed
    case fileDoesNotExist
    case readingDataFailed
}

public actor SOMPersistentDataService<Value: Codable & Identifiable>: NasaMissionPersitentDataServicing {
    private var currentData = [Value]()
    private let fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
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
        currentData.removeAll { $0.id ==  element.id }
    }

    func save(with fileName: String) throws {
        guard let url = makeURL(forFileNamed: fileName) else {
            throw PersistenceError.invalidDirectory
        }

        if fileManager.fileExists(atPath: url.absoluteString) {
            throw PersistenceError.fileAlreadyExist
        }

        do {
            let data = try JSONEncoder().encode(currentData)
            try data.write(to: url)
        } catch {
            debugPrint(error)
            throw PersistenceError.writtingFailed
        }
    }

    func load(from fileNamed: String) throws {
           guard let url = makeURL(forFileNamed: fileNamed) else {
               throw PersistenceError.invalidDirectory
           }
           guard fileManager.fileExists(atPath: url.absoluteString) else {
               throw PersistenceError.fileDoesNotExist
           }
           do {
               let data = try Data(contentsOf: url)
               let entries = try JSONDecoder().decode([Value].self, from: data)
               currentData.append(contentsOf: entries)
           } catch {
               debugPrint(error)
               throw PersistenceError.readingDataFailed
           }
       }
}

private extension SOMPersistentDataService {
    func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
}
