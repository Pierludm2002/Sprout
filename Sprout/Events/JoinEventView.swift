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
                
                // Success message if scanned
                if !scannedCode.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Joined Event!")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(scannedCode)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 28)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
                
                Spacer()
                
                // Scan button
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
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        scannedCode = code
                    }
                    showScanner = false
                }
            }
        }
    }
}

#Preview {
    JoinEventView()
}
