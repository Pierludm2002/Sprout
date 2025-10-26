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
                Color("BrandColor"),
                Color(.white)
            ]), startPoint: .top,
            endPoint: .bottom
        ).edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    GreenBackgroundView()
}
