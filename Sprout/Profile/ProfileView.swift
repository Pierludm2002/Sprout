//
//  ProfileView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 18/10/25.
//

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
    @State private var showQR = false
    
    var body: some View {
        
        let p = profileVM.profile
        
        ScrollView{
            VStack(spacing: 5) {
                HStack{
                    Image("DefaultProfilePic") // used the defalt one for demo 
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
                                .font(.title3)
                                .foregroundColor(.black)
                            Text(p.company)
                                .font(.title3)
                                .foregroundColor(.black)

                            
                        }
                    }
                }
                Divider()
                .padding(.vertical, 20)


                
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
                .onChange(of: profileVM.profile) {
                    print("Profile:")
                    print("Name: \(p.prefName)")
                    print("Occupation: \(p.occupation)")
                    print("Company: \(p.company)")
                    print("Open To: \(p.openTo)")
                    print("Interested In: \(p.interestedIn)")
                    print("Working On: \(p.workingOn)")
                }

                #if DEBUG
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            profileVM.buildQR()
                            showQR = true
                        } label: {
                            Image(systemName: "qrcode")
                        }
                    }
                }
                .sheet(isPresented: $showQR) {
                    VStack(spacing: 20) {
                        if let img = profileVM.qrImage {
                            Image(uiImage: img)
                                .interpolation(.none)
                                .resizable()
                                .frame(width: 260, height: 260)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 8)
                        } else {
                            ProgressView().task { profileVM.buildQR() }
                        }
                        Text("Scan to add \(profileVM.profile.prefName)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Button("Close") { showQR = false }
                    }
                    .padding()
                }
                #endif
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
        iconName: "DefaultProfilePic"
    )
    return NavigationStack {
        ProfileView()
            .environmentObject(vm)
    }
}
