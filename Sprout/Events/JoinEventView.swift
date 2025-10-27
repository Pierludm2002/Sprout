//
//  JoinEventView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 25/10/25.
//

import SwiftUI

struct JoinEventView: View {
    @EnvironmentObject var gardenVM: GardenViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State private var showScanner = false
    @State private var scanResult: ScanResult?
    @State private var showResult = false
    
    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Join an Event")
                        .font(AppStyles.TextStyle.pageTitle)
                        .foregroundColor(.black)
                    
                    Text("Scan the QR code for the event you want to join. Once scanned, all the people you meet will be automatically be added to its garden until the event ends.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.top, 20)
                
                Spacer()
                
                // Show active event if joined
                if let activeId = gardenVM.activeEventId,
                   let activeGarden = gardenVM.gardens.first(where: { $0.id == activeId }) {
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Active Event")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(activeGarden.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text(activeGarden.date)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                        
                        Button("Leave Event") {
                            gardenVM.leaveEvent()
                        }
                        .foregroundColor(.red)
                        .padding(.top, 8)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.5))
                    )
                    .padding(.horizontal, 28)
                }
                
                Spacer()
                
                Button {
                    showScanner = true
                } label: {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(.black)
                        
                        Text("Scan QR Code")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.93, green: 1.00, blue: 0.53))
                    )
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 120)
            }
            .sheet(isPresented: $showScanner) {
                QRScannerView { code in
                    Task {
                        let result = await QRScanHandler.handleScan(
                            code,
                            gardenVM: gardenVM,
                            profileVM: profileVM
                        )
                        await MainActor.run {
                            scanResult = result
                            showResult = true
                            showScanner = false
                        }
                    }
                }
            }
            .alert("Scan Result", isPresented: $showResult) {
                Button("OK") { scanResult = nil }
            } message: {
                if let result = scanResult {
                    switch result {
                    case .eventJoined(let garden):
                        Text("Joined \(garden.title)!")
                    case .profileAdded(let profile):
                        Text("Added \(profile.prefName)!")
                    case .error(let message):
                        Text(message)
                    }
                }
            }
        }
    }
}

#Preview {
    JoinEventView()
}
