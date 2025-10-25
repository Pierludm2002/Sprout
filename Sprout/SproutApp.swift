//
//  SproutApp.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 16/10/25.
//

import SwiftUI

@main
struct SproutApp: App {
    let profileStore: ProfileStore = LocalJSONProfileStore()
    let gardenStore: GardenStore = LocalJSONGardenStore()
    
    var body: some Scene {
        WindowGroup {
            RootSwitcherView()
                .environmentObject(ProfileViewModel(store: profileStore))
                .environmentObject(GardenViewModel(store: gardenStore))
        }
    }
}


struct RootSwitcherView: View {
    @AppStorage("hasCompletedOnboarding") private var done = false
    @EnvironmentObject private var profileVM: ProfileViewModel
    @EnvironmentObject private var gardenVM: GardenViewModel

    var body: some View {
        Group {
            if done {
                BarView()
                    .task {
                        profileVM.load()
                        gardenVM.load()
                    }
            } else {
                OnboardingCoordinatorView {
                    done = true
                }
                .task {
                    profileVM.load()
                }
            }
        }
    }
}
