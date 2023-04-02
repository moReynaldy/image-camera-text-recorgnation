//
//  LiveTextUiImageView.swift
//  ImageTextRecorgnation
//
//  Created by mochamad rizky reynaldy on 02/04/23.
//

import SwiftUI
import VisionKit

@MainActor
struct LiveTextUiImageView: UIViewRepresentable {
    var image: UIImage
    let analyzer = ImageAnalyzer()
    let interaction = ImageAnalysisInteraction()
    let imageview = ResizableImageView()
    
    func makeUIView(context: Context) -> UIImageView {
        imageview.image = image
        imageview.addInteraction(interaction)
        imageview.contentMode = .scaleAspectFit
        return imageview
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        Task {
            do {
            let configuration = ImageAnalyzer.Configuration([.text])
                if let image = imageview.image{
                    let analysis = try await analyzer.analyze(image, configuration: configuration)
                    interaction.analysis = analysis
                    interaction.preferredInteractionTypes = .textSelection
                }
                }catch{
                    print(error)
                }
        }
    }
    
}

class ResizableImageView: UIImageView{
    override var intrinsicContentSize: CGSize{
        .zero
    }
}
