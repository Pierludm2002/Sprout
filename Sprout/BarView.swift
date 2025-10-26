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
                    Text("profile")
                        .font(.title)
                }.tag(1)
                EventsView(
                    garden: gardenVM.gardens.first ?? Garden(title: "—", date: "—", profiles: [])
                )
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                        .font(.title)
                }.tag(2)
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
