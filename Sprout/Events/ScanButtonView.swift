//
//  ScanButtonView.swift
//  Sprout
//
//  Created by Eleonora Persico on 24/10/25.
//

import SwiftUI

struct ScanButtonView: View {
    @EnvironmentObject var gardenVM: GardenViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State private var showScanner = false
    @State private var scanResult: ScanResult?
    @State private var showResult = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                showScanner = true
            }) {
                Label("Scan and connect", systemImage: "qrcode.viewfinder")
                    .fontWeight(.thin)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color(red: 0.93, green: 1.00, blue: 0.53))
                    .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $showScanner) {
            NavigationStack {
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
                .navigationTitle("Scan QR Code")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            showScanner = false
                        }
                    }
                }
            }
        }
        .alert("Scan Result", isPresented: $showResult) {
            Button("OK") { scanResult = nil }
        } message: {
            if let result = scanResult {
                switch result {
                case .profileAdded(let profile):
                    Text("Added \(profile.prefName) to your garden!")
                case .eventJoined(let garden):
                    Text("Joined \(garden.title)!")
                case .error(let message):
                    Text(message)
                }
            }
        }
    }
}

#Preview {
    let gardenVM = GardenViewModel(store: MockGardenStore())
    let profileVM = ProfileViewModel(store: LocalJSONProfileStore())
    
    return ScanButtonView()
        .environmentObject(gardenVM)
        .environmentObject(profileVM)
}

/*

 import SwiftUI

struct ScanButtonView: View {
    @State private var showScanner = false
    @State private var scannedCode: String = ""
    @State private var showCameraDeniedAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                showScanner = true
            }) {
                Label("Scan and connect", systemImage: "qrcode.viewfinder")
                    .fontWeight(.thin)
                
                    .foregroundColor(.black)
                    .padding()
                    .background(Color(red: 0.93, green: 1.00, blue: 0.53))
                    .cornerRadius(10)
            }
            
            if !scannedCode.isEmpty {
                Text("Scanned: \(scannedCode)")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .sheet(isPresented: $showScanner) {
            QRScannerView { code in
                scannedCode = code
                showScanner = false
            }
            .alert("Camera Access Needed",
                          isPresented: $showCameraDeniedAlert) {
                       Button("OK", role: .cancel) {}
                   } message: {
                       Text("Enable camera access in Settings → Sprout → Camera to scan QR codes.")
                   }
        }
    
    }
}


#Preview {
    ScanButtonView()
}

*/
