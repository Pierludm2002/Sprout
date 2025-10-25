//
//  PersonalQRView.swift
//  Sprout
//
//  Created by Eleonora Persico on 24/10/25.
//

import SwiftUI

struct PersonalQRView: View {
    var body: some View {
        ZStack {
            GreenBackgroundView()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Connect with me!")
                            .font(AppStyles.TextStyle.pageTitle)
                        
                        Text("Share your profile to grow your garden!🌱")
                            .fontWeight(.thin)
                    }
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    
                    Spacer() // push left
                    
                    
                }
                Spacer() // pushes top
                
                VStack {
                    
                    ScanButtonView()
                    
                }.padding(.bottom, 50)
            }
            
        }
    }
}

#Preview {
    PersonalQRView()
}
