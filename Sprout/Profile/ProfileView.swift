//
//  ProfileView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 18/10/25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State private var selectedTags: Set<String> = []
    
    var body: some View {
        
        let p = profileVM.profile
        
        ScrollView{
            VStack(spacing: 5) {
                HStack{
                    Image(p.iconName) // use the saved profile's icon
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 5)
                        .padding(40)
                    Spacer()
                }
                HStack{
                    VStack(alignment: .leading){
                        Text(p.prefName)
                            .font(AppStyles.TextStyle.pageTitle)
                            
                        Spacer()
                        
                        HStack{
                            Text(p.occupation)
                                .font(AppStyles.TextStyle.secInfos)
                                .foregroundColor(AppStyles.ColorStyle.secondary)
                            Text(p.company)
                                .font(AppStyles.TextStyle.highlight)
                            
                        }
                        HStack{
                            ForEach(p.socialImage, id: \.self) { iconName in
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
                    FlowLayout(spacing: 8, alignment: .leading) {
                        if p.openTo.isEmpty {
                            Text("No items yet").foregroundStyle(.secondary)
                        } else {
                            ForEach(p.openTo, id: \.self) { open in
                                TagView(title: open)
                                    .font(AppStyles.TextStyle.body)
                                    .padding(1)
                            }
                        }
                    }
                    Divider()
                    HStack{
                        Text("Interested In").font(AppStyles.TextStyle.subtitle)
                        Spacer()
                    }
                    FlowLayout(spacing: 8, alignment: .leading) {
                        if p.interestedIn.isEmpty {
                            Text("No items yet").foregroundStyle(.secondary)
                        } else {
                            ForEach(p.interestedIn, id: \.self) { interest in
                                TagView(title: interest)
                                    .font(AppStyles.TextStyle.body)
                                    .padding(1)
                            }
                        }
                    }
                    Divider()
                    HStack{
                        Text("Working on").font(AppStyles.TextStyle.subtitle)
                        Spacer()
                    }
                    FlowLayout(spacing: 8, alignment: .leading) {
                        if p.workingOn.isEmpty {
                            Text("No items yet").foregroundStyle(.secondary)
                        } else {
                            ForEach(p.workingOn, id: \.self) { work in
                                TagView(title: work)
                                    .font(AppStyles.TextStyle.body)
                                    .padding(1)
                            }
                        }
                    }
                    
                    
                }
    
                
            }.padding(.horizontal, 30)
        }
        .backgroundView()
        .onChange(of: profileVM.profile) { newValue in
            print("Profile:")
            print("Name: \(newValue.prefName)")
            print("Occupation: \(newValue.occupation)")
            print("Company: \(newValue.company)")
            print("Open To: \(newValue.openTo)")
            print("Interested In: \(newValue.interestedIn)")
            print("Working On: \(newValue.workingOn)")
        }
    }
}

#Preview {
    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    vm.profile = Profile(
        prefName: "AnaK",
        occupation: "Student",
        company: "@Apple Developer Academy",
        socialImage: ["instagram", "github"],
        openTo: ["Networking", "Collab"],
        interestedIn: ["Swift", "SwiftUI"],
        workingOn: ["Sprout"],
        iconName: "ge1"
    )
    return NavigationStack {
        ProfileView()
            .environmentObject(vm)
    }
}
