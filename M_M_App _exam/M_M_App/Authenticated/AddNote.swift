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
    
    @ObservedObject var viewModel = AdviceViewmodel()
   
    @State var notes = [Note]()
    
    @State var showSheet:Bool = false
    
    @State var txtTitel = ""
    @State var txtDescription = ""
    
   
    @State var isImageSelected = false
    
    @StateObject var NoteVM = NotesViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dbConnection: DbConnection
    
    @ObservedObject var note:NoteClass

    
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
            if isImageSelected {
                
                TextField("Add titel", text: $txtTitel).focused($isTitleFocused)
                    .padding()
                    .frame(width: 300, height: 40)
                    .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                
                
                TextEditor( text: $txtDescription)
                    .frame(width: 300, height: 150)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        
                    ).padding()
             
                
                
                ///Fetcha Advice API
                Button(action: {
                    
                    Task{
                        do{
                            let fetchedAdvice = try await viewModel.api.fetchAdvice(endpoint: viewModel.adviceEndpoint)
                            txtDescription = fetchedAdvice
                        } catch{
                            txtDescription = "Failed to fetch advice"
                            print(error.localizedDescription)
                        }
                    }
                      
                }, label: {
                    Text("Generate Decription").padding()
                    
                })
                
                
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
                                        dismiss()
                                            print("Note added to firestore")
                                        
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    dismiss()
                                }
                            }
                           
                            
                        }
                    }
                    else{
                        if let user = dbConnection.currentUser{
                            var newNote = Note(titel: txtTitel, description: txtDescription,imageURL: nil)
                            NoteVM.addNoteToFirestore(newNote, forUserId: user.uid)
                            print("note ")
                            dismiss()
                           

                        }
                    }
                   
               
                 }, label: {Text("Add note to DB")})
                
            }/// if closed
              
            
            
                
                
            
            /// Add Photo
            Button(action: {
                self.showSheet = true
            }, label: {
                Text(isImageSelected ? "Choose another photo" : "Add photo")
            }).padding().confirmationDialog("Select Photo", isPresented: $showSheet, actions: {
                
                
                
                
                
                
                
                /// Photo Library
                Button(action: {//self.showImagePicker = true
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }, label: {Text("Photo Library")})
                
                /// Camera
                Button(action: {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }, label: {Text("Camera")})
            })
        .onChange(of: selectedImage){ _ in
           txtDescription = ""
            txtTitel = ""
        }
            // Display the selected image
                           if let selectedImage = selectedImage {
                               Image(uiImage: selectedImage)
                                   .resizable()
                                   .scaledToFit()
                                   .frame(maxWidth: 300, maxHeight: 300)
                                   .onAppear{
                                       isImageSelected = true
                                     
                                   }
                           }
            
            
           
            
            
            
           
            Button("Cancel"){
                dismiss()
            }
            
            
        }
        
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
