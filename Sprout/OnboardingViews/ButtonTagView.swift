//
//  ButtonTagView.swift
//  bloom
//
//  Created by Eleonora Persico on 18/10/25.
//

import SwiftUI

struct ButtonTagView: View {
    
    
    var title: String = "Cool things"
    var action : () -> Void = { }
    var isSelected: Bool = false

    
    var body: some View {
        
        Button(action: action) {
            Text(title)
            
                .fontWeight(.thin)
                .font(.system(size: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(isSelected ? Color.gray.opacity(0.10) : Color.clear)
                .foregroundColor(isSelected ? .black : .primary)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                )
        } //.padding(.horizontal, 10)
    }
}

#Preview {
    ButtonTagView()
}
