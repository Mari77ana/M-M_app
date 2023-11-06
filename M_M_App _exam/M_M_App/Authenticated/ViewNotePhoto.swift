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
    
    var body: some View {
        Text(entry.titel)
        Text(entry.description)
        
        //display image
        if let imageURL = entry.imageURL, let url = URL(string: imageURL){
            AsyncImage(url: url) {
                phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                case .failure:
                    Text("Unable to load")
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: 300,maxHeight: 300)
        }else{
            Text("No image avaible")
        }
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: Note(titel: "hello", description: "hellooo"), journal: NoteClass())
    }
}
