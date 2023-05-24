//
//  RouterExtensions.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 08/05/2023.
//

import SwiftUI

@MainActor
extension View {
    var routingProvided: some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case let .missionDetail(id):
                Text("mission ID: \(id)")
                    .navigationTitle("test")
                    .navigationBarTitleDisplayMode(.inline)

            }
        }
    }

    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .searchSettings:
                SearchSettingsView()
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.ultraThinMaterial)
            }
        }
    }
}
