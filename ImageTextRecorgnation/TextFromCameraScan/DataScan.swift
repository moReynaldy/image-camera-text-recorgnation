//
//  DataScan.swift
//  ImageTextRecorgnation
//
//  Created by mochamad rizky reynaldy on 02/04/23.
//

import SwiftUI
import VisionKit
struct DataScannerVc: UIViewControllerRepresentable{
    @Binding var scannedText: String
    @Binding var liveScan: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(
            recognizedDataTypes: [.text()],
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighlightingEnabled: true
        )
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if liveScan{
           try? uiViewController.startScanning()
        }else{
            uiViewController.stopScanning()
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate{
        let parrent: DataScannerVc
        init(parrent: DataScannerVc) {
            self.parrent = parrent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item{
            case .text(let text):
                parrent.scannedText = text.transcript
                parrent.liveScan = false
            default:
                break
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parrent: self)
    }
}
