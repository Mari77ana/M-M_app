//
//  DbConnection.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-20.
//

import Foundation
import Firebase


class DbConnection: ObservableObject{
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    // Kommande implementation för Databas
    /// let USER_DATA_COLLECTION = "user_data"
    
    @Published var currentUser: User?
    
    init() {
        
        auth.addStateDidChangeListener {auth, user in
            
            if let user = user {
                
                print("User has logged in with email \(user.email ?? "No Email")")
               // self.currentUser = user
               
            }
            else{
                self.currentUser = nil
                print("User has logged out")
            }
            
        }
    }
    
    
    
}
