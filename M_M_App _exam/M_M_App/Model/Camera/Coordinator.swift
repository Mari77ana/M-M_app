//
//  Coordinator.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-11-05.
//

import Foundation
import UIKit

//bridge between pickercontroller and swiftUi
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
  
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    //called when user finished picking, it checks if user selected the image and sets a picker on that selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {return}
            self.picker.selectedImage = selectedImage
            picker.dismiss(animated: true)

    }
}
