//
//  JoinEventView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 25/10/25.
//

import SwiftUI

struct JoinEventView: View {
    @State private var showScanner = false
    @State private var scannedCode = ""
    
    var body: some View {
        ZStack{
            GreenBackgroundView()
            VStack(spacing: 24) {
                Text("Join an Event")
                    .font(.largeTitle).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Scan the QR code for the event you want to join. Once scanned, all the people you meet will be utomatically be added to its garden until the event ends.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Spacer()
                
                Button {
                    showScanner = true
                } label: {
                    Label("Scan QR Code", systemImage: "qrcode.viewfinder")
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: 250)
                        .background(Color(red: 0.93, green: 1.00, blue: 0.53))
                        .cornerRadius(12)
                }
                
                if !scannedCode.isEmpty {
                    VStack {
                        Text("Joined Event:")
                            .font(.headline)
                        Text(scannedCode)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 16)
                }
                
                Spacer()
            }
            .sheet(isPresented: $showScanner) {
                QRScannerView { code in
                    scannedCode = code
                    showScanner = false
                }
            }
        }
    }
}

#Preview {
    JoinEventView()
}
