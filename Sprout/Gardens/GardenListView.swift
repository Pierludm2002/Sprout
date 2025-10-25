//  GardenListView.swift
//  Sprout

import SwiftUI

struct GardenListView: View {
    @EnvironmentObject private var gardenVM: GardenViewModel

    var body: some View {
        
        NavigationStack {
            Group {
                if gardenVM.gardens.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 56))
                            .foregroundStyle(.secondary)
                        Text("No events yet")
                            .font(.title3).fontWeight(.semibold)
                        Text("When you create or join an event, it will show up here.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(gardenVM.gardens, id: \.id) { garden in
                                GardenCardView(garden: garden)
                                    .padding(.horizontal, 16)
                                    .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 10)
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 2)
                        }
                    }
                }
            }
            .background(
                LinearGradient(
                    colors: [Color(.systemGray6), Color(.systemGray6)],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationTitle("My Gardens")
            .navigationBarTitleDisplayMode(.large)
        }
        .task { gardenVM.load() }
        
    }
}

#Preview {
    struct GardenListPreviewHost: View {
        @StateObject var gardenVM = GardenViewModel(store: MockGardenStore())
        @StateObject var profileVM = ProfileViewModel(store: LocalJSONProfileStore())

        var body: some View {
            NavigationStack {
                GardenListView()
                    .environmentObject(gardenVM)
                    .environmentObject(profileVM)
            }
            .task {
                gardenVM.load()
                profileVM.load()
            }
        }
    }
    return GardenListPreviewHost()
}
