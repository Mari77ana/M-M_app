//
//  Note.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift

struct Note: Codable, Identifiable {
    @DocumentID var id: String?
    var titel: String
    var description: String
    
}
