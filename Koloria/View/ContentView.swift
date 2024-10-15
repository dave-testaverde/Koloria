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
            Text(viewModel.imageFormatLabel)
            
            Image(uiImage: viewModel.image)
            
            Text("Filters")
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Button("Grayscale") {
                        viewModel.image = OpenCVWrapper.toGrayscale(viewModel.image)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Gaussian blur") {
                        viewModel.image = OpenCVWrapper.gaussianBlur(viewModel.image, 125)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Resize 320x320") {
                        viewModel.image = OpenCVWrapper.resize(viewModel.image, 320, 320, 0)
                        viewModel.imageFormatLabel = "320px x 320px"
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Resize 250x250") {
                        viewModel.image = OpenCVWrapper.resize(viewModel.image, 250, 250, 0)
                        viewModel.imageFormatLabel = "250px x 250px"
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                }
            }
            
            Text("Tool")
            
            HStack{
                Button("Reset") {
                    viewModel.image = UIImage(named: "lena")!
                    viewModel.imageFormatLabel = "512px x 512px"
                }.buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(12)
                  
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    HStack{
                        Image(systemName: "photo.badge.plus")
                        Text("Upload")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 16)
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
