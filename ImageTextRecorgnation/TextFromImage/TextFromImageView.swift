//
//  TextFromImageView.swift
//  ImageTextRecorgnation
//
//  Created by mochamad rizky reynaldy on 02/04/23.
//

import SwiftUI

struct TextFromImageView: View {
    @Environment(\.dismiss) var dismiss
    private let pastboard = UIPasteboard.general
    let imageToScan: UIImage
    @Binding var scannedText: String
    
    @State private var currentPastboard = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                LiveTextUiImageView(image: imageToScan)
                Text("Select some text and copy it")
                
                Button("Disimis") {
                    if let string = pastboard.string {
                        if !string.isEmpty {
                            scannedText = string
                        }
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Copy text")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            pastboard.string = ""
        }
    }

}

struct TextFromImageView_Previews: PreviewProvider {
    static var previews: some View {
        TextFromImageView(imageToScan: UIImage(), scannedText: .constant(""))
    }
}
