//
//  
//  SearchSettingsView.swift
//  SwiftOnMars
//
//  Created by Martin Lukacs on 23/04/2023.
//
//

import SOMDesignSystem
import SwiftUI
import NasaModels

struct SearchSettingsView: View {
    @StateObject private var viewModel = SearchSettingsViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 20) {
                if !viewModel.manifests.isEmpty {
                    mainForm
                } else {
                    HStack{
                        Spacer()
                    }
                }
                Spacer()
            }

            searchButton
                .opacity(viewModel.manifests.isEmpty ? 0 : 1)
                .padding(.bottom)
        }
        .overlay(alignment: .center) {
            if viewModel.manifests.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
    }
}

private extension SearchSettingsView {
    var mainForm: some View {
        Form {
            titleView
            toggleSearchAction
            roverSelectionView
            if viewModel.selectedMissionManifest != nil {
                if viewModel.searchBySol {
                    missionSelectionDayView
                } else {
                    earthDatePickerView
                }

                cameraSelectionView
            }

        }
        .scrollContentBackground(.hidden)
        .animation(.default, value: viewModel.searchBySol)
    }
}

private extension SearchSettingsView {
    var titleView: some View {
        HStack {
            Text("Search Parameters")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }.padding(.bottom, 10)
    }
}

private extension SearchSettingsView {
    var toggleSearchAction: some View {
        Section(header: Text("Search by").fontWeight(.bold)) {
            Toggle("**\(viewModel.searchBySol ? "Mars exploration days" : "Earth date")**", isOn: $viewModel.searchBySol)
                .padding(.trailing)
                .toggleStyle(SwitchToggleStyle(tint: Asset.Colors.SecondaryColors.primaryAlt.color))
        }
    }
}

private extension SearchSettingsView {
    var roverSelectionView: some View {
        Section(header: Text("Rover selection:").fontWeight(.bold)) {

            Picker(selection: $viewModel.selectedMissionManifest, label: EmptyView()) {
                ForEach(viewModel.manifests, id: \.self) { missionManifest in
                    HStack {
                        Image(imageName: missionManifest.name)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .aspectRatio(contentMode: .fill)
                        Text(missionManifest.name)
                    }.tag(missionManifest as PhotoManifest?)
                        .frame(height: 24)
                }
            }
            .pickerStyle(.inline)
        }
    }
}

private extension SearchSettingsView {
    var missionSelectionDayView: some View {
        Section(header: Text("Day since landing:").fontWeight(.bold)) {
            VStack {
                Slider(
                    value: $viewModel.sol,
                    in: 0...viewModel.maxSol,
                    step: 1
                ) {
                    Text("Sol")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text(viewModel.maxSol.toRoundedDescription)
                } onEditingChanged: { editing in
                    viewModel.isEditing = editing
                }
                HStack {
                    Text("Current selected day:")
                    Text(viewModel.sol.toRoundedDescription)
                }
                .foregroundColor(viewModel.isEditing ? .red : .blue)
            }
        }
    }
}

private extension SearchSettingsView {
    var earthDatePickerView: some View {
        Section(header: Text("Earth Date:").fontWeight(.bold)) {
            DatePicker(
                "Selected Date",
                selection: $viewModel.date,
                displayedComponents: [.date]
            )
        }
    }
}

private extension SearchSettingsView {
    var cameraSelectionView: some View {
        Section(header: Text("Accessible Cameras:").fontWeight(.bold)) {
            Picker(selection:$viewModel.selectedCamera, label: Text("Selected camera:")) {
                ForEach(viewModel.cameras, id: \.self) { camera in
                    Text(camera)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

private extension SearchSettingsView {
    var searchButton: some View {
        Button {
            viewModel.saveParamsAndSearch()
            dismiss()
        } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
        }
        .buttonStyle(.actionButtonStyle)
        .padding([.trailing, .bottom])
    }
}

struct SearchSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSettingsView()
    }
}
