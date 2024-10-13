//
//  HomeViewModel.swift
//  Koloria
//
//  Created by Dave on 12/10/24.
//

import _PhotosUI_SwiftUI

@Observable
class HomeViewModel {
    
    var image: UIImage = UIImage(named: "lena")!
    
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                Task {
                    if let loaded = try? await imageSelection.loadTransferable(type: Data.self) {
                        image = OpenCVWrapper.resize(UIImage(data: loaded)!, 512, 512, 0)
                    } else {
                        print("Import failed")
                    }
                }
            }
        }
    }
    
}
