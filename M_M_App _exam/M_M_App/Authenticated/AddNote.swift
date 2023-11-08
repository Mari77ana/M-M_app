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
    
    @State var showSheet:Bool = false
    
    @State var txtTitel = ""
    @State var txtDescription = ""
    
    @StateObject var NoteVM = NotesViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dbConnection: DbConnection
    
    @ObservedObject var note:NoteClass
        // @Binding var showPopUp: Bool
    
    @FocusState var isTitleFocused:Bool
    @FocusState var isDescriptionFocused:Bool
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    func addNoteToFirestore(_ note:Note){
        do{
            try db.collection("Note 1").addDocument(from: note)
            self.notes.append(note)
            
        } catch _ {
            print("error")
        }}
    var body: some View {
        
        VStack {
            
            TextField("add titel", text: $txtTitel).focused($isTitleFocused)
            
            TextField("add description", text: $txtDescription).focused($isDescriptionFocused)
            
            Button(action: {
                self.showSheet = true
            }, label: {Text("Add photo")}).padding().confirmationDialog("Select Photo", isPresented: $showSheet, actions: {
                
                Button(action: {//self.showImagePicker = true
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }, label: {Text("Photo Library")})
                
                Button(action: {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }, label: {Text("Camera")})
            })
            // Display the selected image
                           if let selectedImage = selectedImage {
                               Image(uiImage: selectedImage)
                                   .resizable()
                                   .scaledToFit()
                                   .frame(maxWidth: 300, maxHeight: 300)
                           }
            
            
            
           Button(action: {
               if let selectedImage = selectedImage{
                   
                   uploadImage(selectedImage){result in
                       
                       DispatchQueue.main.async {
                           
                           switch result{
                               
                           case .success(let url):
                               
                               var newNote = Note(titel: txtTitel, description: txtDescription,imageURL: url.absoluteString)
                               
                               print("Image URL: \(url.absoluteString)")
                               
                               if let user = dbConnection.currentUser {
                                   NoteVM.addNoteToFirestore(newNote, forUserId: user.uid)
                                       print("Note added to firestore")
                               }
                           case .failure(let error):
                               print(error.localizedDescription)
                           }
                       }
                      
                       
                   }
               }else{
                   if let user = dbConnection.currentUser{
                       var newNote = Note(titel: txtTitel, description: txtDescription,imageURL: nil)
                       NoteVM.addNoteToFirestore(newNote, forUserId: user.uid)
                       print("note ")

                   }
               }
              
          
            }, label: {Text("Add note to DB")})
            Button("Cancel"){
                dismiss()
            }
            
            
        }
        .navigationTitle("Demo")
        .sheet(isPresented: self.$isImagePickerDisplay, onDismiss: {
            self.isDescriptionFocused = false
        }){
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(note: NoteClass())
            .environmentObject(DbConnection())
    }
}
