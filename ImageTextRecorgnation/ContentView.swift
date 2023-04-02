//
//  ContentView.swift
//  ImageTextRecorgnation
//
//  Created by mochamad rizky reynaldy on 02/04/23.
//

import SwiftUI
import PhotosUI
import VisionKit

struct ContentView: View {
    @StateObject var imagePicker = ImagePicker()
    @State private var ScannedText = ""
    @FocusState var focusState: Bool
    @State var liveScan = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                TextEditor(text: $ScannedText)
                    .frame(height: 300)
                    .border(Color.red)
                    .focused($focusState)
                if DataScannerViewController.isSupported{
                    Button("Scan with camera"){
                        liveScan.toggle()
                        focusState = false
                    }.buttonStyle(.borderedProminent)
                    Spacer()
                }else{
                    Text("Does not support Live text from camera scan")
                }
                
                
                if ImageAnalyzer.isSupported {
                    PhotosPicker(selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared()){
                        Text("Select image")
                    }
                    .buttonStyle(.borderedProminent)
                }else {
                    Text("Does not support Live text from image")
                }
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button{
                        focusState = false
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down.fill")
                    }
                }
            }
            .navigationTitle("Live text")
            .sheet(isPresented: $liveScan){
                LiveTextFromCameraScan(liveScan: $liveScan, scannedText: $ScannedText)
            }
            .sheet(item: $imagePicker.imageToScan){
                ImageToScan in TextFromImageView(imageToScan: ImageToScan.image, scannedText: $ScannedText)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
