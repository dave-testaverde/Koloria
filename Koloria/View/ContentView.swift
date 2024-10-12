//
//  ContentView.swift
//  Koloria
//
//  Created by Dave on 09/10/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.image)
            
            Text("Filters")
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Button("Grayscale") {
                        let grayImage = OpenCVWrapper.toGrayscale(viewModel.image)
                        viewModel.image = grayImage
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Gaussian blur") {
                        let blurImage = OpenCVWrapper.gaussianBlur(viewModel.image, 125)
                        viewModel.image = blurImage
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Resize") {
                        let resizedImage = OpenCVWrapper.resize(viewModel.image, 320, 320, 0)
                        viewModel.image = resizedImage
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                }
            }
            
            HStack{
                Button("Reset") {
                    viewModel.image = UIImage(named: "lena")!
                }.buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(12)
                  
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Text("Upload")
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(12)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
