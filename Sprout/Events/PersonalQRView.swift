//
//  PersonalQRView.swift
//  Sprout
//
//  Created by Eleonora Persico on 24/10/25.
//

import SwiftUI

struct PersonalQRView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var gardenVM: GardenViewModel
        
        @State private var showScanner = false
        @State private var scanResult: ScanResult?
        @State private var showResult = false

    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nice to meet you!")
                        .font(AppStyles.TextStyle.subtitle)
                        .foregroundColor(.black)
                    
                    Text("I'm \(profileVM.profile.prefName)")
                        .font(AppStyles.TextStyle.pageTitle)
                        .foregroundColor(.black)
                    
                    if !profileVM.profile.occupation.isEmpty || !profileVM.profile.company.isEmpty {
                        Text("\(profileVM.profile.occupation) @\(profileVM.profile.company)")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(.black)
                            .padding(.top, 4)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 16) {
                    if let img = profileVM.qrImage {
                        Image(uiImage: img)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 280, height: 280)
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
                            )
                    } else {
                        ProgressView()
                            .frame(width: 280, height: 280)
                    }
                    
                    Text("Share your profile with others and grow your gardens!")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                Spacer()
                
                ScanButtonView()
                .padding(.horizontal, 32)
                .padding(.bottom, 100)
            }
        }
        .task(id: profileVM.profile.id) {
            if profileVM.qrImage == nil { profileVM.buildQR() }
        }
    }
}

#Preview {
    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    vm.profile = Profile(
        prefName: "Ana Rodriguez",
        occupation: "iOS Developer",
        company: "Apple",
        iconName: "ge1"
    )
    return NavigationStack {
        PersonalQRView()
            .environmentObject(vm)
    }
}
