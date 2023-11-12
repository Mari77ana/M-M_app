//
//  ViewNotePhoto.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import SwiftUI

struct ViewNotePhoto: View {
    var entry: Note
    @ObservedObject var journal: NoteClass
    @EnvironmentObject var themeColor: ThemeColor
    
    var body: some View {
        ZStack{
            
            Text(entry.titel).padding()
            
            
            //display image
            if let imageURL = entry.imageURL, let url = URL(string: imageURL){
                AsyncImage(url: url) {
                    phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                        //.scaledToFit()
                            .frame(width:  380, height: 400).padding(15)
                    case .failure:
                        Text("Unable to load")
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(entry.description).padding()
                Spacer()
                
            }else{
                Text("No image avaible")
            }
        }
        
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: Note(titel: "hello", description: "hellooo"), journal: NoteClass())
            .environmentObject(ThemeColor())
    }
}
