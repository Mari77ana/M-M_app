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
     let USER_DATA_COLLECTION = "user_data"
    
    @Published var currentUser: User?
    
    init() {
        
        auth.addStateDidChangeListener { [self] auth, user in
            
            if let user = user {
                
                print("User has logged in with email \(user.email ?? "No Email")")
                self.currentUser = user
               
            }
            else{
                currentUser = nil
                print("User has logged out")
            }
            
        }
    }
    
    
   /*
    func startListeningToDb(){
        
        db.collection(self.USER_DATA_COLLECTION).addSnapshotListener{
            snapshot, error in
            
            if let error = error {
                print("Error occured \(error.localizedDescription)")
                return
            }
            guard let snapshot = snapshot else{return}
            
            for document in snapshot.documents{
                let result = Result{
                   // try document.data(as: ProfileView.self)
                }
            }
            
        }
        
    }
    */
     
    
    
    
    // * REGISTER USER *
    func RegisterUser(firstname: String, lastname: String, email: String, password: String) -> Bool{
        
        var success = false
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                success = false
               
            }
            if let _ = authResult{
                print("Account successfully created")
                success = true
            }
            
        }
        return success
       
    }// Reg Ends
    
    
    
    
    
    // * LOGIN USER *
    func LoginUser(email: String, password: String) -> Bool{
        
        var success = false
        auth.signIn(withEmail: email, password: password){ AuthDataResult, error in
            
            if let error = error{
                print("Error logging in")
                success = false
            }
            if let _ = AuthDataResult{
                print("Logged in successfully")
                success = true
            }
            
        }
        return success
        
    }// Log Ends
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
