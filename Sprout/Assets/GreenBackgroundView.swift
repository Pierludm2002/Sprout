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
            gradient: Gradient(stops: [
                .init(color: Color("BrandColor"), location: 0.0),
                .init(color: Color(.whitish), location: 0.25),
                .init(color: Color(.whitish), location: 1.0)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    GreenBackgroundView()
}
