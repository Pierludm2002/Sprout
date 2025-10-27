//
//  CardInfoView.swift
//  bloom
//
//  Created by Pourya Mazinani on 17/10/25.
//

import SwiftUI

struct CardInfoView: View {
    @Binding var preferredName: String
    @Binding var jobTitle: String
    @Binding var company: String

    let onNext: () -> Void
    let onBack: (() -> Void)?

    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Hello, welcome to Sprout!")
                        .font(AppStyles.TextStyle.pageTitle)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.top, 20)
                
                Spacer()
                    .frame(minHeight: 30, maxHeight: 50)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What should we call you?")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .padding(.leading, 4)
                        
                        TextField("", text: $preferredName)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0.3)),
                                alignment: .bottom
                            )
                    }
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("What’s your role or field?")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .padding(.leading, 4)
                        
                        TextField("", text: $jobTitle)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0.3)),
                                alignment: .bottom
                            )
                    }
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Where are you currently working or studying?")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .padding(.leading, 4)
                        
                        TextField("", text: $company)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray.opacity(0.3)),
                                alignment: .bottom
                            )
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 28)
                
                Spacer()
                
                Button(action: onNext) {
                    HStack {
                        Text("Continue")
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
                .padding(.bottom, 40)
                .disabled(preferredName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .toolbar {
            if let onBack {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: onBack) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
