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
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var note:NoteClass
        // @Binding var showPopUp: Bool
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        VStack {
            
           TextField("add titel", text: $txtTitel)
            
           TextField("add description", text: $txtDescription)
            
           Button(action: {
               
                let newNote = Note(titel: txtTitel, description: txtDescription)
                note.addEntry(entry: newNote)
              
                //showPopUp = false
                do{
                  
                   try db.collection("Note 1").addDocument(from: newNote)
                    dismiss()
                   
                } catch let error {
                        print(error.localizedDescription)
                }
            }, label: {Text("Add note to DB")})
            Button("Cancel"){
                dismiss()
            }
            
            
        }
    
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(note: NoteClass())
    }
}
