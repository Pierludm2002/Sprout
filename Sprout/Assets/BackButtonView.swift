//
//  BackButtonView.swift
//  bloom
//
//  Created by Eleonora Persico on 18/10/25.
//

import SwiftUI

struct BackButtonView: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("←")
                .fontWeight(.thin)
                .foregroundStyle(.black)
                .padding(8)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .accessibilityLabel("Back")
    }
}

#Preview {
    BackButtonView { }
        .padding()
}
