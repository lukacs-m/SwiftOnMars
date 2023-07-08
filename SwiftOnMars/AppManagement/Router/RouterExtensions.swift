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
            case let .photoDetail(photo):
                DetailView(viewModel: DetailViewModel(photo: photo))
            default:
                Text("Not implemented yet")
            }
        }
    }

    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .searchSettings:
                SearchSettingsView()
                    .presentationDetents([.large])
                    .presentationBackground(.ultraThinMaterial)
            }
        }
    }

}
