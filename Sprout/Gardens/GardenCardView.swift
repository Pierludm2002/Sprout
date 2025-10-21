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
    @State private var canvasHeight: CGFloat = 200
    
    
    private let gardenSideInset: CGFloat = 16 // left/right margin inside the garden area
    private let gardenTopInset: CGFloat = 12 // space below the date text
    private let gardenBottomInset: CGFloat = 16 // space above the card’s bottom
    
    private func layout(for size: CGSize) {
        let result = ringLayout(
            count: garden.profiles.count,
            width: size.width,
            height: size.height,
            iconDiameter: 40,
            spacing: 5,
            ringGap: 6,
            centerHole: 2,
            verticalPadding: 16
        )
        self.positions = result.points
        self.canvasHeight = result.requiredHeight
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(garden.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(garden.date)
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.vertical, 2)
            
            GeometryReader { geo in
                ZStack {
                    // Loop through every profile (icon)
                    ForEach(Array(garden.profiles.enumerated()), id: \.1.id) { (idx, profile) in
                        // Uses precomputed positions; if empty, default to center
                        let pos = positions.count > idx
                        ? positions[idx]
                        : CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
                        
                        Button {
                            // toggles selection for animation
                            selectedIndex = (selectedIndex == idx ? nil : idx)
                            // assigns selected profile to trigger the modal
                            selectedProfile = profile
                        } label: {
                            Image(profile.iconName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .scaleEffect(selectedIndex == idx ? 1.15 : 1.0)
                        }
                        .position(pos) // places icon absolutely inside the geometry area
                        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedIndex)
                    }
                }
                .onAppear { layout(for: geo.size) }
                .onChange(of: geo.size) { _, newSize in layout(for: newSize) } // keeps it safe if width changes
                .onChange(of: garden.profiles.count) { _, _ in layout(for: geo.size) } // recompute if the number of icons changes
            }
            .frame(height: canvasHeight)
        }
        .sheet(item: $selectedProfile) { profile in
            ProfileModal(profile: profile)
                .presentationDetents([.medium, .large]) // draggable sheet sizes
                .presentationDragIndicator(.visible)
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
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
        }
    }
    
    /// Places icons in rings around the geometric center of the canvas.
    ///
    /// - Parameters:
    ///   - count: Total number of icons to display
    ///   - width: The available width from GeometryReader
    ///   - height: The available height from GeometryReader
    ///   - iconDiameter: The total visual size of one icon (used to calculate spacing)
    ///   - spacing: How far apart icons are on the same ring
    ///   - ringGap: Vertical distance between rings
    ///   - centerHole: How big the empty space in the middle is (distance before the first ring starts)
    ///   - verticalPadding: Padding added above and below the layout to avoid clipping
    
    private func ringLayout(
        count: Int,
        width: CGFloat,
        height: CGFloat,
        iconDiameter: CGFloat = 40,
        spacing: CGFloat = 12,
        ringGap: CGFloat = 16,
        centerHole: CGFloat = 60,
        verticalPadding: CGFloat = 16
    ) -> (points: [CGPoint], requiredHeight: CGFloat) {
        guard count > 0 else { return ([], iconDiameter + 2*verticalPadding) }
        
        let cx = width / 2
        let cy = height / 2
        var points: [CGPoint] = []

        // Place the first icon exactly at the geometric center of the canvas
        points.append(CGPoint(x: cx, y: cy))
        if count == 1 {
            // Height needs to fit just one icon plus vertical padding
            let h = iconDiameter + 2 * verticalPadding
            return (points, h)
        }
        
        var remaining = count - 1
        var ring = 0
        
        var maxRadius: CGFloat = 0
        
        while remaining > 0 {
            // Distance from the center to the centerline of the ring
            let r = centerHole + CGFloat(ring + 1) * (iconDiameter + ringGap)
            maxRadius = max(maxRadius, r)
            
            // How many icons fit around this ring
            let circumference = 2 * .pi * r
            let perIcon = iconDiameter + spacing
            let capacity = max(1, Int(floor(circumference / perIcon)))
            
            let n = min(remaining, capacity)
            let step = 2 * .pi / CGFloat(max(n,1))
            let phase = (ring % 2 == 0) ? 0 : step / 2
            
            for i in 0..<n {
                let a = phase + CGFloat(i) * step
                let x = cx + r * cos(a)
                let y = cy + r * sin(a)
                points.append(CGPoint(x: x, y: y))
            }
            
            remaining -= n
            ring += 1
        }
        
        // Total height must cover the farthest ring plus padding (centered vertically)
        let requiredHeight = 2 * (maxRadius + iconDiameter / 2) + 2 * verticalPadding
        return (points, requiredHeight)
    }
}

#Preview {
    GardenCardView(garden: GardenMocks.gardens.first!)
}
