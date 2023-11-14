//
//  StorageDB.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-11-06.
//


import Foundation
import SwiftUI
import Firebase
import FirebaseStorage



    //upload image function that takes in the image and has closure returning URL or error
func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
    
    //data conversion
    guard let imageData = image.jpegData(compressionQuality: 0.75) else {
        return completion(.failure(ImageUploadError.imageConversionFailed))
    }
    
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let imagesRef = storageRef.child("images/\(UUID().uuidString).jpg")
    // upload content type
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    
   //upload image
    imagesRef.putData(imageData, metadata: metadata) { metadata, error in
        guard metadata != nil else {
            completion(.failure(ImageUploadError.uploadFailed(error!)))
            return
        }
       
        // Fetch the download URL
        imagesRef.downloadURL { url, error in
            if let error = error {
               
                completion(.failure(ImageUploadError.urlRetrievalFailed(error)))
                
            } else if let url = url {
               
                completion(.success(url))
            }
        }
    }
}
enum ImageUploadError: Error {
    case imageConversionFailed
    case uploadFailed(Error)
    case urlRetrievalFailed(Error)
}
