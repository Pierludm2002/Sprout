//
//  PersonalQRView.swift
//  Sprout
//
//  Created by Eleonora Persico on 24/10/25.
//

import SwiftUI


struct PersonalQRView: View {
    @EnvironmentObject var profileVM: ProfileViewModel

    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Connect with me!")
                        .font(AppStyles.TextStyle.pageTitle)

                    Text("Share your profile to grow your garden! 🌱")
                        .fontWeight(.thin)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                .padding(.horizontal, 20)

                Group {
                    if let img = profileVM.qrImage {
                        Image(uiImage: img)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 260, height: 260)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8)
                            .accessibilityLabel("QR code for \(profileVM.profile.prefName)")
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                Spacer()

                ScanButtonView()
                    .padding(.bottom, 50)
            }
        }
        // Generate once when the view appears or when profile changes
        .task(id: profileVM.profile.id) {
            if profileVM.qrImage == nil { profileVM.buildQR() }
        }
    }
}

#Preview {
    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    return NavigationStack {
        PersonalQRView()
            .environmentObject(vm)
    }
}
