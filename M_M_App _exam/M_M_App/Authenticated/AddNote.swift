//
//  AddNote.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import SwiftUI
import FirebaseFirestore


struct AddNote: View {
    var db = Firestore.firestore()
    @State var notes = [Note]()
    @State var txtTitel = ""
    @State var txtDescription = ""
    @ObservedObject var note:NoteClass
    @Binding var showPopUp: Bool
    var body: some View {
        VStack {
            
           TextField("add titel", text: $txtTitel)
            
           TextField("add description", text: $txtDescription)
            
           Button(action: {
               
                let newNote = Note(titel: txtTitel, description: txtDescription)
                note.addEntry(entry: newNote)
                showPopUp = false
                do{
                  
                   try db.collection("Note 1").addDocument(from: newNote)
                   
                } catch let error {
                        print(error.localizedDescription)
                }
            }, label: {Text("Add note to DB")})
            
            
        }
    
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(note: NoteClass(),showPopUp: .constant(true))
    }
}
