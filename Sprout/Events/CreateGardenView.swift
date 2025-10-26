//
//  CreateGardenView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 24/10/25.
//

import SwiftUI

struct CreateGardenView: View {
    
    @Binding var gardenName: String
    @State var date = Date()
    
    var body: some View {
        ZStack{
            GreenBackgroundView()
            
            VStack{
                Text("Create a new Garden!").font(AppStyles.TextStyle.pageTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                
                Form{
                    TextField("Garden name", text: $gardenName){
                        
                    }
                        .listRowBackground(Color.clear)
                    DatePicker("Start date",
                               selection: $date,
                               displayedComponents: [.date]
                    ).datePickerStyle(.compact)
                        .listRowBackground(Color.clear)
                       
                    
                }.scrollContentBackground(.hidden)
                
                Spacer()
                                    
                        Section{
                            ContinueButtonView(title: "Create ->"){
                                print("New Garden Generated")
                                
                                //TODO: generate QR
                                
                            }.padding()
                        }
                
                
            }
            
            
        }
    }
    
}

#Preview {
    CreateGardenView(gardenName: .constant("TecView") )
}
