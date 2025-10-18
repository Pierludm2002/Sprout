//
//  ProfileView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 18/10/25.
//

import SwiftUI

struct ProfileView: View {
    
    var name: String = "Ping Xiao Po"
    var occupation: String = "Guerriero Dragon"
    var company: String = "@Jade Palace"
    var socialImage: [String] = ["instagram", "github"]
    var openTo: [String] = ["Web Development", "Other", "Things", "Yellow"]
    var interestedIn: [String] = ["Swift", "Operative Systems"]
    var workingOn: [String] = ["Swift"]
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 5) {
                HStack{
                    Image("poAvatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 80))
                        .shadow(radius: 5)
                        .cornerRadius(50)
                        .padding(40)
                    Spacer()
                }
                HStack{
                    VStack(alignment: .leading){
                        Text(name)
                            .font(AppStyles.TextStyle.pageTitle)
                            
                        Spacer()
                        
                        HStack{
                            Text(occupation)
                                .font(AppStyles.TextStyle.secInfos)
                                .foregroundColor(AppStyles.ColorStyle.secondary)
                            Text(company)
                                .font(AppStyles.TextStyle.highlight)
                            
                        }
                        HStack{
                            ForEach(socialImage, id: \.self) { iconName in
                                Image(iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 8)
                            }
                            Spacer()
                        }.padding(.top,5).padding(.bottom, 5)
                    }
                }
                Divider()
                
                VStack{
                    HStack{
                        Text("Open To").font(AppStyles.TextStyle.subtitle)
                            Spacer()
                    }
                   HStack { //I found out that the only solution to have multiple elements of different size on multiple lines is with a flow layout.
                        ForEach(openTo, id: \.self) { open in
                            Text(open)
                                .font(AppStyles.TextStyle.body)
                                .padding(5)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.tint)
                                        .opacity(0.2)
                                }
                        }
                    }
                    Divider()
                    HStack{
                        Text("Interested In").font(AppStyles.TextStyle.subtitle)
                        Spacer()
                    }
                    HStack{
                        ForEach(interestedIn, id: \.self) {
                            interest in
                            Text(interest)
                                .font(AppStyles.TextStyle.body)
                                .padding(5)
                                .background{
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.tint)
                                        .opacity(0.2)
                                }
                        }
                        Spacer()
                    }
                    Divider()
                    HStack{
                        Text("Working on").font(AppStyles.TextStyle.subtitle)
                        Spacer()
                    }
                    HStack{
                        ForEach(workingOn, id: \.self){
                            work in
                            Text(work)
                                .font(AppStyles.TextStyle.body)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.tint)
                                        .opacity(0.2)
                                    )
                            
                        }
                        Spacer()
                    }
                    
                    
                }
    
                
            }.padding(.horizontal, 30)
            
            
            
        }.backgroundView()
    }
}


#Preview {
    ProfileView()
}
