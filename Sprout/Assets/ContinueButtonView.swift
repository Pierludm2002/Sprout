//
//  ContinueButtonView.swift
//  bloom
//
//  Created by Eleonora Persico on 19/10/25.
//

import SwiftUI

struct ContinueButtonView: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: 325, height: 60, alignment: .leading)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundStyle(Color(red: 0.93, green: 1.00, blue: 0.53))
                )
                .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .buttonStyle(.plain)
        .contentShape(RoundedRectangle(cornerRadius: 18))
        .accessibilityLabel(title)
    }
}

#Preview {
    ContinueButtonView(title: "Continue  →") { }
        .padding()
}
