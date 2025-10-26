//
//  PhotoSelectionOnboardingView.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//



import SwiftUI
import PhotosUI

struct PhotoOnboardingView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    let onNext: () -> Void
    let onBack: (() -> Void)?
    
    var body: some View {
        ZStack {
            GreenBackgroundView()
            
            VStack (spacing: 20) {
                Text("Help others find you at events")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Would you like to share a picture of yourself? This is optional.")
                    .fontWeight(.thin)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer()
                
                PhotosPicker(selection: $selectedItem,
                             matching: .images) {
                    if let selectedImage {
                        
                        selectedImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 227, height: 227)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                           
                    } else {
                        
                        AddPhotoButtonView()
                    }
                }
                
                Spacer()
                
                VStack {
                    
                    ContinueButtonView(title: "Continue  →") {
                       onNext()
                    }
                }
                
                Spacer()
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}



#Preview {
    PhotoOnboardingView(onNext: {},
                        onBack: nil)
}

