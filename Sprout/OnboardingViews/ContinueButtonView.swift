//
//  ContinueButtonView.swift
//  bloom
//
//  Created by Eleonora Persico on 19/10/25.
//

import SwiftUI

var title = "Continue                                              →"
var action : () -> Void = { }
var isPressed = false

struct ContinueButtonView: View {
    var body: some View {
        
        Button(action: action) {
            
            Text(title)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .frame(width: 325, alignment: .leading)
                .cornerRadius(18)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundStyle(Color(red: 0.93, green: 1.00, blue: 0.53))
                        .frame(width: 325, height: 60)
                    )
            
        
        }
    }
}

#Preview {
    ContinueButtonView()
}
