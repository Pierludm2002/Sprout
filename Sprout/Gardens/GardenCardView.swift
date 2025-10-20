//
//  GardenCardView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 19/10/25.
//

import SwiftUI

struct GardenCardView: View {
    let garden: Garden
    
    @State private var positions: [CGPoint] = []
    @State private var selectedIndex: Int? = nil
    @State private var selectedProfile: Profile? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(garden.title)
                .font(.title3).fontWeight(.semibold)
            
            Text(garden.date)
                .font(.footnote).fontWeight(.medium)
                .padding(.vertical, 2)
            
            GeometryReader { geo in
                ZStack {
                    ForEach(Array(garden.profiles.enumerated()), id: \.1.id) { (idx, profile) in
                        let pos = positions.count > idx
                            ? positions[idx]
                            : CGPoint(x: geo.size.width/2, y: geo.size.height/2)
                        
                        Button {
                            selectedIndex = (selectedIndex == idx ? nil : idx)
                            selectedProfile = profile
                        } label: {
                            Image(profile.iconName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 45)
                                .scaleEffect(selectedIndex == idx ? 1.15 : 1.0)
                        }
                        .position(pos)
                        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedIndex)
                    }
                }
                .onAppear {
                    if positions.isEmpty {
                        positions = simpleRingPositions(
                            count: garden.profiles.count,
                            in: geo.size,
                            iconDiameter: 15,
                            spacing: 10,
                            ringGap: 7,
                            centerHole: 70
                        )
                    }
                }
            }
            .sheet(item: $selectedProfile) { profile in
                ProfileModal(profile: profile)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            .frame(height: 260)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.15))
        )
        .shadow(radius: 2)
    }
    
    private struct ProfileModal: View {
        let profile: Profile

        var body: some View {
            VStack(spacing: 16) {
                Image(profile.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .padding(8)
                    .background(Circle().fill(Color(.secondarySystemBackground)))

                Text(profile.prefName)
                    .font(.title2).fontWeight(.semibold)
            }
            .padding()
        }
    }
    
    private func simpleRingPositions(
        count: Int,
        in size: CGSize,
        iconDiameter: CGFloat = 30,
        spacing: CGFloat = 10,
        ringGap: CGFloat = 10,
        centerHole: CGFloat = 50
    ) -> [CGPoint] {
        var pts: [CGPoint] = []
        let cx = size.width / 2, cy = size.height / 2
        guard count > 0 else { return pts }

        // 1 elem in center (IDK??????????????????)
        pts.append(CGPoint(x: cx, y: cy))
        if count == 1 { return pts }

        var remaining = count - 1
        var ring = 0
        let perIcon = iconDiameter + spacing

        while remaining > 0 {
            let r = centerHole + CGFloat(ring) * (iconDiameter + ringGap)
            let circumference = 2 * .pi * r
            let capacity = max(1, Int(floor(circumference / perIcon)))
            let n = min(remaining, capacity)

            let step = 2 * .pi / CGFloat(n)
            let phase = (ring % 2 == 0) ? 0 : step / 2

            for k in 0..<n {
                let a = phase + CGFloat(k) * step
                let x = cx + r * cos(a)
                let y = cy + r * sin(a)
                pts.append(CGPoint(x: x, y: y))
            }

            remaining -= n
            ring += 1
        }
        return pts
    }
}


#Preview {
    GardenCardView(garden: GardenMocks.gardens.first!)
}
