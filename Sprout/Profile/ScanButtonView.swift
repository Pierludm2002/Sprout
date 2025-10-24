//
//  ScanButtonView.swift
//  Sprout
//
//  Created by Eleonora Persico on 24/10/25.
//

import SwiftUI

struct ScanButtonView: View {
    @State private var showScanner = false
    @State private var scannedCode: String = ""
    
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
        }
    }
}
#Preview {
    ScanButtonView()
}
