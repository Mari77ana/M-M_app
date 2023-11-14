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
    
    //catch  notes from DB
    
//    func getNotesDB(_ note:Note, forUserId userId: String){
//        db.collection("user_data").document(userId).collection("notes").getDocuments{(snapshot error  )}
//                                                               
//    }
//    
    func getNotes()-> [Note]{
        return notes
    }
    //add note to DB
    func addNoteToFirestore(_ note:Note,forUserId userId: String) {
        do{
            
            let userDocumentRef = db.collection("user_data").document(userId).collection("notes")
            try userDocumentRef.addDocument(from: note)
            
            
            showPopUp = false}
        catch let error {
            
            DispatchQueue.main.async {
                print("\(error)")
                
            }
          
        }}
    
    
    func startListeningToDb(foruserId userId: String){ /// Funktionen skulle kunna flyttas till Dbonnection, är en Model

       // guard let currentUser = dbConnection.currentUser else {return}
        
        db.collection("user_data").document(userId).collection("notes").addSnapshotListener{
             snapshot, error in
             
             if let error = error {
                 print("error occured \(error.localizedDescription)")
                 return
             }
             //if we havent received any error then the snapshot has received a value
             guard let snapshot = snapshot else{return}
            
            var newNotes : [Note] = []
            
            
             for document in snapshot.documents{
                 let result = Result {
                     try document.data(as: Note.self)
                 }
                 
                 switch result {
                 case .success(let note):
         
                     newNotes.append(note)
                    
                         print(note.titel)
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
            
            self.notes = newNotes
         }
     }

    
}

