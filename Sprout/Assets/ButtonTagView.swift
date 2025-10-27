//
//  ButtonTagView.swift
//  bloom
//
//  Created by Eleonora Persico on 18/10/25.
//

import SwiftUI

struct ButtonTagView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16))
                .fontWeight(.thin)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundColor(isSelected ? .black : .primary)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.greyish : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                )
        }
        .buttonStyle(.plain)
        .contentShape(RoundedRectangle(cornerRadius: 16))
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    ButtonTagView(title: "Cool things", isSelected: false) { }
        .padding()
}
