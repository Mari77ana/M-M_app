//
//  Grid.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import Foundation
import SwiftUI


struct Grid: View {
    
    @ObservedObject var noteVM: NotesViewModel
    
    let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 80, alignment: nil),
        GridItem(.fixed(50), spacing: 80, alignment: nil),
        GridItem(.fixed(50), spacing: 80, alignment: nil)
    ]

    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                
                ForEach(noteVM.notes) { entry in
                    
                    if let imageURL = entry.imageURL, let url = URL(string: imageURL) {
                        
                        // AsyncImage to load and display the image
                        NavigationLink(destination: ViewNotePhoto(entry: entry, noteVM: noteVM)) {
                            
                            AsyncImage(url: url) { image in
                                
                                image.resizable()
                                
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)
                            .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}
