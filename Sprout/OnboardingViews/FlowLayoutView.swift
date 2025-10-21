//
//  FlowLayoutView.swift
//  sprout_ele
//
//  Created by Eleonora Persico on 20/10/25.
//

import Foundation
import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    var alignment: HorizontalAlignment = .center  // Add this
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing,
            alignment: alignment
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing,
            alignment: alignment
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(
                at: CGPoint(x: bounds.minX + result.origins[index].x, y: bounds.minY + result.origins[index].y),
                proposal: .unspecified
            )
        }
    }
    
    struct FlowResult {
        var origins: [CGPoint] = []
        var size: CGSize = .zero
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat, alignment: HorizontalAlignment) {
            // First pass: calculate row information
            var rows: [[Int]] = []
            var rowWidths: [CGFloat] = []
            var currentRow: [Int] = []
            var x: CGFloat = 0
            var y: CGFloat = 0
            var rowHeight: CGFloat = 0
            
            for (index, subview) in subviews.enumerated() {
                let size = subview.sizeThatFits(.unspecified)
                
                if x + size.width > maxWidth && x > 0 {
                    rows.append(currentRow)
                    rowWidths.append(x - spacing)
                    currentRow = []
                    x = 0
                    y += rowHeight + spacing
                    rowHeight = 0
                }
                
                currentRow.append(index)
                rowHeight = max(rowHeight, size.height)
                x += size.width + spacing
            }
            
            if !currentRow.isEmpty {
                rows.append(currentRow)
                rowWidths.append(x - spacing)
            }
            
            // Second pass: position items with centering
            y = 0
            rowHeight = 0
            
            for (rowIndex, row) in rows.enumerated() {
                let rowWidth = rowWidths[rowIndex]
                let startX = alignment == .center ? (maxWidth - rowWidth) / 2 : 0
                x = startX
                
                for index in row {
                    let subview = subviews[index]
                    let size = subview.sizeThatFits(.unspecified)
                    
                    origins.append(CGPoint(x: x, y: y))
                    rowHeight = max(rowHeight, size.height)
                    x += size.width + spacing
                }
                
                y += rowHeight + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: y - spacing)
        }
    }
}
