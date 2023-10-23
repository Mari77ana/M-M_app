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
    let USER_DATA_COLLECTION = "user_data" // UserData() = "user_data"
    
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    var dbListener: ListenerRegistration?
    
    
    // * App Starts Here *
    init() {
        
        auth.addStateDidChangeListener { [self] auth, user in
            
            if let user = user {
                
                /// User has logged in
                print("User has logged in with email \(user.email ?? "No Email")")
                self.currentUser = user
                
                ///
                self.startListeningToDb()
                
            }
            else{
                /// User has logged out, cleans all data
                self.dbListener?.remove() /// have to listnen at a time, stop listening if user has loged out
                self.dbListener = nil
                self.currentUser = nil
                self.currentUserData = nil
                print("User has logged out")
            }
            
        }
    }
    
    
    
    func startListeningToDb(){
        
        guard let user = currentUser else{return}
        
        /// Listening only on the user id document , not the hole collection ,  use user.uid
        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener{
            snapshot, error in
            
            if let error = error {
                print("Error occured \(error.localizedDescription)")
                return
            }
            guard let documentSnapshot = snapshot else{return}
            
            let result = Result{
                try documentSnapshot.data(as: UserData.self)
            }
            switch result{
            case  .success(let UserData):
                self.currentUserData = UserData
            case .failure(let error) :
                print(error.localizedDescription)
            }
            
            
        }
        
    }// startListening ends
    
   
    
    
    
    
    // * REGISTER USER *
    func RegisterUser(firstname: String, lastname: String, email: String, password: String) -> Bool{
        
        var success = false
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                success = false
                
            }
            if let authResult = authResult{
                
                /// UserData Object creates as a  unic Document  sor that user in Firebase Database and pushes
                let newUserData = UserData(firstname: firstname, lastname: lastname)
                do{
                    try self.db.collection(self.USER_DATA_COLLECTION).document(authResult.user.uid).setData(from: newUserData)
                    print("Account successfully created")
                    success = true
                    
                }catch{
                    print("Error: \(error.localizedDescription)")
                }
                
            }
            
        }
        return success
        
    }// Reg Ends
    
    
    
    
    
    
    
    
    // * LOGIN USER *
    func LoginUser(email: String, password: String, completion: @escaping (Bool) -> Void){
        
    
        auth.signIn(withEmail: email, password: password){ [weak self] AuthDataResult, error in
            
            if let error = error{
    
                print("Error: \(error.localizedDescription)")
                self?.currentUser = nil //
                completion(false) /// user not register
              
            }
            
            else if let AuthDataResult = AuthDataResult{
                    self?.currentUser = AuthDataResult.user
                    print("Success loggged in with same user")
                completion(true)
                  
                }
        
            
        }
       // return success
        
        
    }// Log Ends
    
    
    
    
    
    
    
    
    
}
