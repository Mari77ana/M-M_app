//
//  ViewNotePhoto.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import SwiftUI
import Firebase

struct ViewNotePhoto: View {
    
    var entry: Note
    var image:UIImage?
    @ObservedObject var noteVM: NotesViewModel
    @EnvironmentObject var themeColor: ThemeColor
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            themeColor.colorSchemeMode().ignoresSafeArea()
            themeColor.themeFormCircle()
            themeColor.themeFormRoundenRectangle()
            
            VStack{
                Text(entry.titel).padding()
                    .foregroundStyle(themeColor.isDarkModeEnabled ? Color.gray : Color.black)
                
                
             //display image
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 400, height: 400)
                        .padding(15)
                }else if let imageURL = entry.imageURL, let url = URL(string: imageURL) {
                    // Load and display the image from URL
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .frame(width: 400, height: 400)
                            .padding(15)
                    } placeholder: {
                        ProgressView()
                    }
                }
                else {
                      Text("No image available")
                          .foregroundStyle(themeColor.isDarkModeEnabled ? Color.gray : Color.black)
                                }
                
                Button("Delete") {
                              if let userId = Auth.auth().currentUser?.uid {
                                  noteVM.deleteNote(entry, forUserId: userId)
                                  presentationMode.wrappedValue.dismiss()  // Dismiss the view after deletion
                              }
                          }
                          .buttonStyle(.bordered)
                          .foregroundColor(.red)
                          .padding(.bottom,15)
            }
        }
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: Note(titel: "hello", description: "hellooo"), noteVM: NotesViewModel())
            .environmentObject(ThemeColor())
    }
}
