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
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Create an event")
                        .font(AppStyles.TextStyle.pageTitle)
                        .foregroundColor(.black)
                    
                    Text("Set up your event details below")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.top, 20)
                
                Spacer()
                    .frame(minHeight: 20, maxHeight: 40)
                
                
                Form {
                    Section {
                        TextField("Event name", text: $gardenName)
                            .font(.system(size: 18))
                            .listRowBackground(Color.clear)
                        
                        DatePicker(
                            "Start date",
                            selection: $date,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .font(.system(size: 18))
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(height: 180)
                
                Spacer()
                    .frame(minHeight: 20, maxHeight: 40)
                
                Spacer()
                    .frame(minHeight: 30, maxHeight: 60)
                
                Button(action: {
                    Task { @MainActor in
                        if let _ = gardenVM.createdGarden {
                            showQR = true
                        } else {
                            let trimmed = gardenName.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !trimmed.isEmpty else { return }
                            await gardenVM.createGarden(title: trimmed, date: date)
                            if gardenVM.errorMessage == nil {
                                showQR = true
                            }
                        }
                    }
                }) {
                    HStack {
                        Text(gardenVM.createdGarden == nil ? "Create event" : "View my event")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.93, green: 1.00, blue: 0.53))
                    )
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 120)
                .disabled(gardenName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && gardenVM.createdGarden == nil)
            }
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

private struct GardenQRSheet: View {
    let garden: Garden?
    let qr: UIImage?
    let onClose: () -> Void
    let onClearLock: () -> Void
    
    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your event is ready!")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.black)
                    
                    if let g = garden {
                        Text(g.title)
                            .font(AppStyles.TextStyle.pageTitle)
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                        
                        Text(g.date)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.gray)
                            .padding(.top, 2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.top, 20)
                
                Spacer()
                    .frame(minHeight: 20, maxHeight: 40)
                
                VStack(spacing: 12) {
                    if let img = qr {
                        Image(uiImage: img)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 260, height: 260)
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white)
                                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
                            )
                    } else {
                        ProgressView()
                            .frame(width: 260, height: 260)
                    }
                    
                    Text("Share this QR with your guests to let them join!")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.gray.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                        .lineLimit(2)
                }
                
                Spacer()
                    .frame(minHeight: 20, maxHeight: 40)
                
                VStack(spacing: 12) {
                    Button(action: onClose) {
                        HStack {
                            Text("Done")
                                .font(.system(size: 19, weight: .light))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 19, weight: .light))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.93, green: 1.00, blue: 0.53))
                        )
                    }
                    
                    Button(action: onClearLock) {
                        Text("Clear & Create New Event")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 40)
            }
        }
    }
}
