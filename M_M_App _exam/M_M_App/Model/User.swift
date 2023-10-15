//
//  User.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    
    // Document has an ID
    @DocumentID var id: String?
    var category = "user"
    var firstname: String
    var lastname: String
    var email: String
    var password: String
    var date = Date()
    
    
}
// In need for converting to document to Database
enum CodingKeys: String, CodingKey{
    case category
    case firstname
    case lastname
    case email
    case password
    case date
}
