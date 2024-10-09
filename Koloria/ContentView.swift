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
                .resizable()
                .frame(width: 512, height: 512)
            
            Text("Filters")
            
            Button("Grayscale") {
                let grayImage = OpenCVWrapper.toGrayscale(image)
                image = grayImage
            }
            
            Button("Gaussian blur") {
                let blurImage = OpenCVWrapper.gaussianBlur(image, 125)
                image = blurImage
            }
            
            Button("Resize") {
                let resizedImage = OpenCVWrapper.resize(image, 320, 320, 0)
                image = resizedImage
            }
            
            Button("Reset") {
                image = UIImage(named: "lena")!
            }
        }
    }
}

#Preview {
    ContentView()
}
