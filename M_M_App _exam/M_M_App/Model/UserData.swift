//
//  UserData.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-21.
//

import Foundation
import FirebaseFirestoreSwift


struct UserData {
    
    @DocumentID var id: String?
    var firstname: String
    var lastname: String
   // var notes: [Notes]
    
    
}
