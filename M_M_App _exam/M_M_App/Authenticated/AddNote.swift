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
    
    @ObservedObject var NoteVM :NotesViewModel
    @ObservedObject var viewModel = AdviceViewmodel()
    
    @State var notes = [Note]()
    @State var showSheet:Bool = false
    @State var txtTitel = ""
    @State var txtDescription = ""
    @State var isImageSelected = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dbConnection: DbConnection
    @EnvironmentObject var themeColor: ThemeColor
   
    @FocusState var isTitleFocused:Bool
    @FocusState var isDescriptionFocused:Bool
    
    var body: some View {
        
        ZStack{
            
            themeColor.colorSchemeMode().ignoresSafeArea()
            themeColor.themeFormCircle()
            themeColor.themeFormRoundenRectangle()
            
            VStack {
                
                // Add Photo
                Button(action: {
                    self.showSheet = true
                }, label: {
                    Text(isImageSelected ? "Choose another photo" : "Add photo")
                })
                .padding()
                .confirmationDialog("Select Photo", isPresented: $showSheet, actions: {
                    
                    
                    // Photo Library
                Button(action: {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }, label: {
                    Text("Photo Library")
                })
                    
                    
                    // Camera
                Button(action: {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }, label: {
                    Text("Camera")
                })
                    
                })//confirmation dialog ends
                
                .onChange(of: selectedImage){ _ in
                    txtDescription = ""
                    txtTitel = ""
                }
                // Display the selected image
                if let selectedImage = selectedImage {
                    
                    ZStack{
                        
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                            .cornerRadius(10)
                            .padding()
                            .onAppear{
                                isImageSelected = true
                        }
                    }
                }
                
                if isImageSelected {
                    
                    TextField("Add titel", text: $txtTitel).focused($isTitleFocused)
                        .padding()
                        .frame(width: 300, height: 40)
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                        .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .cornerRadius(8)
                    
                    
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
                        Text("Generate Decription").padding(.bottom,10)
                        
                    })
                    
                    //add image to db
                    Button(action: {
                       
                        if let selectedImage = selectedImage{
                            
                            uploadImage(selectedImage){result in
                                
                                DispatchQueue.main.async {
                                    
                                    switch result{
                                        
                                    case .success(let url):
                                        
                                        var newNote = Note(titel: txtTitel, description: txtDescription,imageURL: url.absoluteString)
                                        
                                        if let user = dbConnection.currentUser {
                                            NoteVM.addNoteToFirestore(newNote, forUserId: user.uid)
                                            dismiss()
                                        }
                                        
                                    case .failure(let error):
                                        
                                        print(error.localizedDescription)
                                        dismiss()
                                    }
                                }
                            }
                        }
                    }, label: {Image(systemName: "arrow.forward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(10)
                            .background(Circle().fill(Color.blue))
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                            .padding(.bottom)
                    })
                    
                }// if closed
                
                
                // Buton Cancel
                Button("Cancel"){
                    dismiss()
                }.foregroundStyle(Color.red)
                
            }.sheet(isPresented: self.$isImagePickerDisplay, onDismiss: {
                self.isDescriptionFocused = false
                
            }){
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
            
        }/// ZStack ends
    }
}





struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(NoteVM: NotesViewModel())
            .environmentObject(DbConnection())
            .environmentObject(ThemeColor())
    }
}
