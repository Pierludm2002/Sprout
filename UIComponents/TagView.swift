//
//  TagView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 21/10/25.
//

import SwiftUI

struct TagView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
        
            .fontWeight(.thin)
            .font(.system(size: 16))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.white)
            .foregroundColor(.primary)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                    .foregroundStyle(Color.white)
            )
    }
}

#Preview {
    TagView(title: "Hackaton")
}
