//
//  ImagePickerView.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-11-05.
//

import Foundation
import SwiftUI
import UIKit

//view that allows user to pick from photo library

struct ImagePickerView: UIViewControllerRepresentable{
   
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    //camera or photo library
    var sourceType: UIImagePickerController.SourceType
    
    //self  modified view controller designed for the usage of camera or library together with the controller
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //pickerview does not need to update state. it operates independently. Still needs to conform to protocol
    }
    //instans coordinator class, communicates with swiftUI when user picks an image
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
}
