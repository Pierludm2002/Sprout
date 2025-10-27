//
//  BarView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 17/10/25.
//

import SwiftUI

struct BarView: View {
    
    @EnvironmentObject var gardenVM: GardenViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .tag(1)
            
            NavigationStack {
                ConnectCoordinatorView()
            }
            .tabItem {
                Image(systemName: "qrcode")
                Text("Connect")
            }
            .tag(2)
            
            NavigationStack {
                GardenListView()
            }
            .tabItem {
                Image(systemName: "leaf.fill")
                Text("Gardens")
            }
            .tag(3)
        }
        .task { await gardenVM.load() }
    }
}

#Preview("BarView – Store-backed") {
    let vm = GardenViewModel(store: MockGardenStore())
    let profileVM = ProfileViewModel(store: LocalJSONProfileStore())
    Task { await vm.load() }
    return BarView()
        .environmentObject(vm)
        .environmentObject(profileVM)
}
