//
//  GardenListView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 19/10/25.
//

import SwiftUI


struct GardenListView: View {
    private let gardens = GardenMocks.gardens

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(gardens, id: \.id) { garden in
                        GardenCardView(garden: garden)
                            .padding(.horizontal, 16)
                            .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 10)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 2)
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
    }
}

#Preview {
    GardenListView()
}
