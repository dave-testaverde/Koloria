//
//  ContentView.swift
//  Koloria
//
//  Created by Dave on 09/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var image = UIImage(named: "lena")!
    var body: some View {
        VStack {
            Image(uiImage: image)
            
            Text("Filters")
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Button("Grayscale") {
                        let grayImage = OpenCVWrapper.toGrayscale(image)
                        image = grayImage
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Gaussian blur") {
                        let blurImage = OpenCVWrapper.gaussianBlur(image, 125)
                        image = blurImage
                    }.buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    
                    Button("Resize") {
                        let resizedImage = OpenCVWrapper.resize(image, 320, 320, 0)
                        image = resizedImage
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
                    image = UIImage(named: "lena")!
                }.buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(12)
                
                Button("Upload") {
                    
                }
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

#Preview {
    ContentView()
}
