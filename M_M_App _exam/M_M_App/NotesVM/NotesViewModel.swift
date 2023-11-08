//
//  NotesViewModel.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-11-07.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift // import for addDocument(:from)

class NotesViewModel: ObservableObject {
    
    var db = Firestore.firestore()
    @Published var notes:[Note] = []
    @Published var showPopUp: Bool = false
    
    func addNoteToFirestore(_ note:Note,forUserId userId: String){
        do{
            
            let userDocumentRef = db.collection("user_data").document(userId).collection("notes")
            try userDocumentRef.addDocument(from: note)
            
            
            self.notes.append(note)
            
            showPopUp = false}
        catch let error {
            
            DispatchQueue.main.async {
                print("\(error)")
                
            }
          
        }}
    
}
