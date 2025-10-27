//
//  CreateGardenView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 24/10/25.
//

import SwiftUI

struct CreateGardenView: View {
    @EnvironmentObject private var gardenVM: GardenViewModel
    
    @State private var gardenName: String = ""
    @State private var date: Date = Date()
    @State private var showQR = false
    
    var body: some View {
        ZStack{
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Create an event")
                    .font(AppStyles.TextStyle.pageTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Form {
                    Section {
                        TextField("Garden name", text: $gardenName)
                            .listRowBackground(Color.clear)
                        
                        DatePicker(
                            "Start date",
                            selection: $date,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                ContinueButtonView(
                    title: gardenVM.createdGarden == nil ? "Create  →" : "My Event  →"
                ) {
                    print("Continue tapped")
                    Task { @MainActor in
                        if let _ = gardenVM.createdGarden {
                            showQR = true
                            print("Showing existing QR")
                        } else {
                            let trimmed = gardenName.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !trimmed.isEmpty else { return }
                            await gardenVM.createGarden(title: trimmed, date: date)
                            if gardenVM.errorMessage == nil {
                                showQR = true
                                print("Created and showing QR")
                            } else {
                                print("\(gardenVM.errorMessage ?? "Unknown error")")
                            }
                        }
                    }
                }
                .padding()
                .disabled(gardenName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && gardenVM.createdGarden == nil)
            }
            
            .task {
                if gardenVM.createdGarden != nil {
                    showQR = true
                }
            }
            .sheet(isPresented: $showQR) {
                GardenQRSheet(
                    garden: gardenVM.createdGarden,
                    qr: gardenVM.createdGardenQR,
                    onClose: { showQR = false },
                    onClearLock: {
                        gardenVM.clearCreatedGardenLock()
                        showQR = false
                    }
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

private struct GardenQRSheet: View {
    let garden: Garden?
    let qr: UIImage?
    let onClose: () -> Void
    let onClearLock: () -> Void
    
    var body: some View {
        ZStack{
            Color("Greyish")
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Your event QR")
                    .font(AppStyles.TextStyle.pageTitle)
                
                if let g = garden {
                    Text(g.title).font(.headline)
                    Text(g.date).foregroundStyle(.secondary)
                }
                
                if let img = qr {
                    Image(uiImage: img)
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 260, height: 260)
                        .background(.greyish)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 8)
                } else {
                    ProgressView()
                }
                
                Text("Share this QR with your guests. You can’t create another event until this one is cleared.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack {
                    Button("Close", action: onClose)
                    Spacer()
                    Button("Clear & Create New") { onClearLock() }
                        .tint(.red)
                }
                .padding(.top, 8)
            }
            .padding()
        }
    }
}
