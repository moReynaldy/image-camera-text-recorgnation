//
//  ImagePicker.swift
//  PhotosPicker
//
//  Created by mochamad rizky reynaldy on 02/04/23.
//

import SwiftUI
import PhotosUI

@MainActor
class ImagePicker: ObservableObject {
    
    @Published var image: Image? // baris ini buat pick photo from photo library and asign as image property than we can display on the view
   
    @Published var images: [Image] = []
    
    @Published var imageToScan: ImageToScan?
    
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        } // baris ini
    }
    
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task {
                if !imageSelections.isEmpty {
                    try await loadTransferable(from : imageSelections)
                    imageSelections = []
                }
            }
        }
    }
    
    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do{
            for imageSelection in imageSelections {
                if let data = try await imageSelection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data){
                        
                        self.imageToScan = ImageToScan(image: uiImage)
                        
                        self.images.append(Image(uiImage: uiImage))
                    }
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    self.image = Image(uiImage: uiImage)
                }
            }
        }catch{
            print(error.localizedDescription)
            image = nil
        }
    }
}

struct ImageToScan: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
}

