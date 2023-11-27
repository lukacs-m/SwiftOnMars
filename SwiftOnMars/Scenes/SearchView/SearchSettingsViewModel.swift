//
//
//  SearchSettingsViewModel.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 23/04/2023.
//
//

import Combine
import Factory
import Foundation
import NasaModels

@MainActor
final class SearchSettingsViewModel: ObservableObject, Sendable {
    @Published private(set) var manifests: [PhotoManifest] = []
    @Published var searchBySol = true
    @Published var date = Date()
    @Published var sol = 0.0
    @Published var isEditing = false
    @Published var selectedMissionManifest: PhotoManifest?
    @Published var selectedMissionManifestName: String?
    @Published var selectedCamera: String = SearchSettingsViewModel.allCameraKey

    private let getAllOrderedRoverManifests = resolve(\UseCasesContainer.getAllOrderedRoverManifests)
    private let saveNewSearchParams = resolve(\UseCasesContainer.saveNewSearchParams)
    private let getCurrentSearchParameters = resolve(\UseCasesContainer.getCurrentSearchParameters)

    private var task: Task<Void, any Error>?
    private static let allCameraKey = "ALL"
    private var cancellables = Set<AnyCancellable>()

    var maxSol: Double {
        guard let sol = selectedMissionManifest?.maxSol else {
            return 0
        }
        return sol.toDouble
    }

    var cameras: [String] {
        guard var cameras = selectedMissionManifest?.photos.first(where: filterPhoto)?.cameras else {
            return [Self.allCameraKey]
        }
        cameras.append(Self.allCameraKey)
        return cameras.sorted()
    }

    init() {
        selectedCamera = Self.allCameraKey
        setUp()
    }

    deinit {
        task?.cancel()
    }

    func selectMissionManifest(from manifest: PhotoManifest) {
        resetSearchParams()
        selectedMissionManifest = manifest
    }

    func isMissionSelected(from manifest: PhotoManifest) -> Bool {
        guard let selectedMissionManifest else {
            return false
        }
        return selectedMissionManifest == manifest
    }

    func isCameraSelected(with camera: String) -> Bool {
        selectedCamera == camera
    }

    func selectCamera(with camera: String) {
        selectedCamera = camera
    }

    func saveParamsAndSearch() {
        guard let newParams = createSearchParams() else {
            return
        }
        saveNewSearchParams(with: newParams)
    }
}

// MARK: - Utils

private extension SearchSettingsViewModel {
    func setUp() {
        task?.cancel()
        task = Task { [weak self] in
            guard let self else {
                return
            }
            do {
                if Task.isCancelled {
                    return
                }
                self.manifests = try await self.getAllOrderedRoverManifests().map(\.photoManifest)
                self.setCurrentSearchParams()
            } catch {
                print(error)
            }
        }

        $selectedMissionManifest
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.resetSearchParams()
            }
            .store(in: &cancellables)
    }

    func resetSearchParams() {
        searchBySol = true
        date = Date()
        sol = 0.0
        selectedCamera = Self.allCameraKey
    }

    func createSearchParams() -> SearchParameters? {
        guard let selectedManifest = selectedMissionManifest else {
            return nil
        }
        return SearchParameters(roverId: RoverIdentification.value(for: selectedManifest.name.lowercased()),
                                sol: sol.toInt,
                                earthDate: date,
                                searchBySol: searchBySol,
                                camera: selectedCamera == Self.allCameraKey ? nil : selectedCamera)
    }

    func setCurrentSearchParams() {
        let searchParams = getCurrentSearchParameters().value
        searchBySol = searchParams.searchBySol
        date = searchParams.earthDate ?? Date()
        sol = searchParams.sol.toDouble
        selectedCamera = searchParams.camera ?? Self.allCameraKey
        selectedMissionManifest = manifests.first { $0.name.lowercased() == searchParams.roverId.rawValue }
    }

    func filterPhoto(_ element: PhotoInformation) -> Bool {
        searchBySol ? element.sol == sol.toInt : element.earthDate == date.toEarthDateDescription
    }
}
