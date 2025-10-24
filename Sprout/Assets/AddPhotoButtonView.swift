//
//  AddPhotoButtonView.swift
//  Sprout
//
//  Created by Eleonora Persico on 22/10/25.
//

import SwiftUI

struct AddPhotoButtonView: View {
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 227, height: 227)
                .foregroundStyle(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 0.3)
                )
            
            Text("+")
                .fontWeight(.thin)
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    AddPhotoButtonView()
}


