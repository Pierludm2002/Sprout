//
//  GreenBackgroundView.swift
//  bloom
//
//  Created by Eleonora Persico on 18/10/25.
//

import SwiftUI

struct GreenBackgroundView: View {
    var body: some View {
        
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.76, green: 0.88, blue: 0.77),
                Color(.white)
            ]), startPoint: .top,
            endPoint: .bottom
        ).edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    GreenBackgroundView()
}
