//
//  LiveTextFromCameraScan.swift
//  ImageTextRecorgnation
//
//  Created by mochamad rizky reynaldy on 02/04/23.
//

import SwiftUI

struct LiveTextFromCameraScan: View {
    @Environment(\.dismiss) var dismis
    @Binding var liveScan: Bool
    @Binding var scannedText: String
    
    var body: some View {
        VStack{
            DataScannerVc(scannedText: $scannedText, liveScan: $liveScan)
            Text("Capture text")
            Button("cancel"){
                dismis()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Capture text")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LiveTextFromCameraScan_Previews: PreviewProvider {
    static var previews: some View {
        LiveTextFromCameraScan(liveScan: .constant(false), scannedText: .constant(""))
    }
}
