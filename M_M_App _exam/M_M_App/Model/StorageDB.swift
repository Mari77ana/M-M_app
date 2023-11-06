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




func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.75) else {
        return completion(.failure(ImageUploadError.imageConversionFailed))
    }
    
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let imagesRef = storageRef.child("images/\(UUID().uuidString).jpg")
    
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    
    imagesRef.putData(imageData, metadata: metadata) { metadata, error in
        guard metadata != nil else {
            // Uh-oh, an error occurred!
            completion(.failure(error!))
            return
        }
        // You can also use the metadata to get more information about the uploaded file
        
        // Fetch the download URL
        imagesRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                completion(.failure(error))
            } else if let url = url {
                // Get the download URL
                completion(.success(url))
            }
        }
    }
}
enum ImageUploadError: Error {
    case imageConversionFailed
    case uploadFailed
    case urlRetrievalFailed
}
