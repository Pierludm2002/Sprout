//
//  SocialLinkButtonView.swift
//  Sprout
//
//  Created by Eleonora Persico on 26/10/25.
//

import SwiftUI

struct URLButton: View {
    let imageName: String
    let urlString: String
    let size: CGFloat
    let color: Color
    
    init(imageName: String = "link.circle.fill",
         urlString: String,
         size: CGFloat = 60,
         color: Color = .blue) {
        self.imageName = imageName
        self.urlString = urlString
        self.size = size
        self.color = color
    }
    
    var body: some View {
        Button(action: {
            openURL()
        }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(color)
        }
    }
    
    func openURL() {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

struct SocialLinkButtonView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            URLButton(
                imageName: "link",
                urlString: "https://www.instagram.com/_eleonorapersico/",
                size: 30,
                color: .black
            )
            
        }
    }
}


#Preview {
    SocialLinkButtonView()
}
