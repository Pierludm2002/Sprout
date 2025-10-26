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
        ZStack{
            
            LinearGradient(colors: [.green, .white], startPoint: .top , endPoint: .bottom).ignoresSafeArea()
            TabView() {
                ProfileView().tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                        .font(.title)
                }.tag(1)
                
                ConnectCoordinatorView().tabItem {
                    Image(systemName: "qrcode")
                    Text("Connect")
                        .font(.title)
                }.tag(3)
                
                
                GardenListView().tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Gardens")
                        .font(.title)
                }.tag(3)
                
            }
            .task { await gardenVM.load() }
            
        }
    }
}

#Preview("BarView – Store-backed") {
    let vm = GardenViewModel(store: MockGardenStore())
    // Preload mock data for the preview
    Task { await vm.load() }
    return BarView()
        .environmentObject(vm)
}
