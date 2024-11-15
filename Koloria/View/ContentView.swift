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
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    @State private var showCamera = false
    
    var body: some View {
        VStack {
            Text("\(Int(viewModel.image.size.width))px x \(Int(viewModel.image.size.height))px")
            
            Image(uiImage: viewModel.image)
                .scaleEffect(currentZoom + totalZoom)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentZoom = value.magnification - 1
                        }
                        .onEnded { value in
                            totalZoom += currentZoom
                            currentZoom = 0
                        }
                )
                .accessibilityZoomAction { action in
                    if action.direction == .zoomIn {
                        totalZoom += 1
                    } else {
                        totalZoom -= 1
                    }
                }
            
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
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Stack blur") {
                        viewModel.image = OpenCVWrapper.stackBlur(viewModel.image, 125)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Box filter") {
                        viewModel.image = OpenCVWrapper.boxFilter(viewModel.image)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Bilateral filter") {
                        viewModel.image = OpenCVWrapper.bilateralFilter(viewModel.image)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Flip Horizontally Axis") {
                        viewModel.image = OpenCVWrapper.flip_axes(viewModel.image, Direction.HORIZONTALLY)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Flip Vertically Axis") {
                        viewModel.image = OpenCVWrapper.flip_axes(viewModel.image, Direction.VERTICALLY)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Flip Both Axis") {
                        viewModel.image = OpenCVWrapper.flip_axes(viewModel.image, Direction.BOTH)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Filter 2D") {
                        viewModel.image = OpenCVWrapper.filter2D(viewModel.image)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Filter 2D A") {
                        viewModel.image = OpenCVWrapper.filter2D_a(viewModel.image)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Filter 2D B") {
                        viewModel.image = OpenCVWrapper.filter2D_b(viewModel.image)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Median blur") {
                        viewModel.image = OpenCVWrapper.medianBlur(viewModel.image, 125)
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Resize 250x250") {
                        viewModel.image = OpenCVWrapper.resize(viewModel.image, 250, 250, 0)
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
                    currentZoom = 0.0
                    totalZoom = 1.0
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
                
                HStack{
                    Image(systemName: "camera")
                    Button("Camera") {
                        self.showCamera.toggle()
                    }.fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: $viewModel.image)
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.horizontal, 16)
                .padding(.vertical, 7)
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(12)
            }
        }
    }
}

extension ContentView {
    
    struct Direction {
        static let BOTH: Int32 = -1
        static let HORIZONTALLY: Int32 = 0
        static let VERTICALLY: Int32 = 1
    }
    
}

#Preview {
    ContentView()
}
