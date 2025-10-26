//
//  ConnectCoordinatorView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 25/10/25.
//

import SwiftUI

struct ConnectCoordinatorView: View {
    enum Tab: String, CaseIterable {
        case connect = "Connect"
        case join = "Join Event"
        case create = "Create Event"
    }

    @State private var selectedTab: Tab = .connect
    @EnvironmentObject private var gardenVM: GardenViewModel
    @State private var draftGardenName: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Picker("", selection: $selectedTab) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            Group {
                switch selectedTab {
                case .connect:
                    PersonalQRView()
                case .join:
                    JoinEventView()
                case .create:
                    CreateGardenView()
                }
            }
            .animation(.easeInOut, value: selectedTab)
        }
        .padding(.top, 10)
        .background(Color(.brand))
    }
}

#Preview {
    let profileVM = ProfileViewModel(store: LocalJSONProfileStore())
    let gardenVM = GardenViewModel(store: LocalJSONGardenStore())

    return ConnectCoordinatorView()
        .environmentObject(profileVM)
        .environmentObject(gardenVM)
}
