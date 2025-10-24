//
//  ProfileIconsView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 24/10/25.
//

import SwiftUI

struct ProfileIconsView: View {
    let profiles: [Profile]
    let positions: [CGPoint]
    let fallbackCenter: CGPoint

    @Binding var selectedIndex: Int?
    @Binding var selectedProfile: Profile?

    var body: some View {
        ForEach(Array(profiles.enumerated()), id: \.1.id) { (idx, profile) in
            let pos = positions.count > idx ? positions[idx] : fallbackCenter

            Button {
                selectedIndex = (selectedIndex == idx ? nil : idx)
                selectedProfile = profile
            } label: {
                Image(profile.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .scaleEffect(selectedIndex == idx ? 1.15 : 1.0)
            }
            .position(pos)
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedIndex)
        }
    }
}

#Preview {
    struct Harness: View {
        @State private var selectedIndex: Int? = nil
        @State private var selectedProfile: Profile? = nil

        let profiles: [Profile] = [
            .init(prefName: "Ana", iconName: "ge1"),
            .init(prefName: "Shifu", iconName: "ge2"),
            .init(prefName: "Tigress", iconName: "ge3"),
        ]

        var body: some View {
            ZStack {
                Color.green.opacity(0.1)
                ProfileIconsView(
                    profiles: profiles,
                    positions: [
                        CGPoint(x: 80, y: 80),
                        CGPoint(x: 140, y: 140),
                        CGPoint(x: 200, y: 80)
                    ],
                    fallbackCenter: CGPoint(x: 120, y: 120),
                    selectedIndex: $selectedIndex,
                    selectedProfile: $selectedProfile
                )
                .frame(width: 240, height: 200)
            }
        }
    }

    return Harness()
}
