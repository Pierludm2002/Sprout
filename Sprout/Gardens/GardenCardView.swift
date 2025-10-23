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
            
            HStack {
                Text(garden.title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                NavigationLink(destination: GardenNameList()) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
            }
            
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
                            // animation
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
                        .position(pos) // places icon inside the geo area
                        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedIndex)
                    }
                }
                .onAppear { layout(for: geo.size) }
                .onChange(of: geo.size) { _, newSize in layout(for: newSize) } // keeps it safe if width changes
                .onChange(of: garden.profiles.count) { _, _ in layout(for: geo.size) } // recompute if the number of icons changes
            }
            .frame(height: canvasHeight)
        }
        // modal when clicked
        .sheet(item: $selectedProfile) { profile in
            ProfileView(
                    name: profile.prefName,
                    occupation: "Guerriero Dragon Student",
                    company: "@Apple Developer Academy",
                    socialImage: ["instagram", "github"],
                    openTo: ["Networking", "Collab"],
                    interestedIn: ["Swift", "SwiftUI"],
                    workingOn: ["Sprout App"]
                )
                .presentationDetents([.medium, .large])
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
    
    private func ringLayout(
        count: Int,
            width: CGFloat,
            height: CGFloat,
            iconDiameter: CGFloat = 40, // Image().frame
            spacing: CGFloat = 12, // gap between neighbors in the ring
            ringGap: CGFloat = 18, // distance between rings
            centerHole: CGFloat = 70,// how far the first ring is from the center
        sideInset: CGFloat = 0.1,// left/right padding that must be respected
            verticalPadding: CGFloat = 24 // extra breathing room in height computation
    ) -> (points: [CGPoint], requiredHeight: CGFloat) {
        
        guard count > 0 else { return ([], iconDiameter + 2*verticalPadding) }
        
        let cx = width / 2
        let cy = height / 2
        var points: [CGPoint] = []
        
        // place 1 exactly in the center first
        points.append(CGPoint(x: cx, y: cy))
        if count == 1 {
            return (points, iconDiameter + 2*verticalPadding)
        }
        
        var remaining = count - 1
        var ring = 0
        var maxRadius: CGFloat = 0
        
        // per-item arc
        let perIconArc: CGFloat = iconDiameter + spacing
        
        // usable width once side insets and icon radius are considered
        let halfIcon = iconDiameter / 2
        let usableHalfWidth = max(0, (width - 2*sideInset)/2 - halfIcon)
        
        while remaining > 0 {
            let r = centerHole + CGFloat(ring + 1) * (iconDiameter + ringGap)
            maxRadius = max(maxRadius, r)
            
            // full circle is available by default
            var allowedSpans: [(start: CGFloat, end: CGFloat)] = [(0, 2*CGFloat.pi)]
            
            // if this ring would violate the side padding restrict to top/bottom arcs
            if r > usableHalfWidth {
                let ratio = min(1, max(0, usableHalfWidth / r))
                let alpha = acos(ratio)
                
                let topStart = alpha
                let topEnd = CGFloat.pi - alpha
                let bottomStart = CGFloat.pi + alpha
                let bottomEnd = 2*CGFloat.pi - alpha
                
                allowedSpans = []
                if topEnd > topStart { allowedSpans.append((topStart, topEnd)) }
                if bottomEnd > bottomStart { allowedSpans.append((bottomStart, bottomEnd)) }
            }
            
            // angular length available on this ring
            let totalAngle = allowedSpans.reduce(0) { $0 + ($1.end - $1.start) }
            // circumference available
            let effectiveCircumference = r * totalAngle
            let capacity = max(1, Int(floor(effectiveCircumference / perIconArc)))
            
            let toPlace = min(remaining, capacity)
            
            // distribute items proportionally across allowed spans
            var itemsLeft = toPlace
            var placedThisRing = 0
            
            // helper to place items evenly
            func place(_ n: Int, in span: (start: CGFloat, end: CGFloat)) {
                guard n > 0 else { return }
                let a = span.start, b = span.end
                let spanLen = b - a
                // even spacing inside the arc or if n == 1, its put in the middle
                let step = n > 1 ? spanLen / CGFloat(n) : 0
                for i in 0..<n {
                    let mid = n > 1 ? (a + (CGFloat(i) + 0.5) * step) : (a + spanLen/2)
                    let x = cx + r * cos(mid)
                    let y = cy + r * sin(mid)
                    points.append(CGPoint(x: x, y: y))
                }
            }
            
            for (idx, span) in allowedSpans.enumerated() {
                if itemsLeft == 0 { break }
                let share = (span.end - span.start) / max(totalAngle, .ulpOfOne)
                let n = (idx == allowedSpans.count - 1)
                ? itemsLeft
                : min(itemsLeft, max(0, Int(round(share * CGFloat(toPlace)))))
                place(n, in: span)
                itemsLeft -= n
                placedThisRing += n
            }
            
            remaining -= placedThisRing
            ring += 1
        }
        
        let requiredHeight = 2 * (maxRadius + halfIcon) + 2 * verticalPadding
        return (points, requiredHeight)
        
    }
}

#Preview {
    GardenCardView(garden: GardenMocks.gardens.first!)
}
