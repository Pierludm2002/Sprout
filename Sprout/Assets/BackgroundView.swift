//
//  BackgroundView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 18/10/25.
//

import SwiftUI

struct BackgroundView: ViewModifier {
    let gradientColors: [Color] = [ .gradientSet, .gradientBottom]
    func body(content: Content) -> some View {
        ZStack{
            LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            content
        }
    }
}

extension View {
    func backgroundView() -> some View {
        self.modifier(BackgroundView())
    }
}
