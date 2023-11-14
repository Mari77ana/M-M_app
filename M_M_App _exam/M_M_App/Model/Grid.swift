//
//  Grid.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import Foundation
import SwiftUI

//struct Grid: View {
//
//    @ObservedObject var noteClass: NoteClass
//
//    let columns: [GridItem] = [
//
//        GridItem(.fixed(50), spacing: 30, alignment: nil),
//        GridItem(.fixed(50), spacing: 30, alignment: nil),
//        GridItem(.fixed(50), spacing: 30, alignment: nil)
//
//    ]
//    var body: some View{
//
//
//        ScrollView{
//            LazyVGrid(columns: columns,
//                      alignment: .center,
//                      spacing: 15,
//                      pinnedViews: [],
//                      content: {
//                ForEach(noteClass.getNotes()){
//                entry in
//                    if let imageURL = entry.imageURL, let url = URL(string: imageURL){
//                        NavigationLink(destination: ViewNotePhoto(entry: entry, journal: NoteClass)){
//                            AsyncImage(url: url){ image in
//                                image.resizable()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(width: 70, height: 80)
//                            .cornerRadius(8)
//                        }
//                    } else{
//                        NavigationLink(destination: ViewNotePhoto(entry: entry, journal: NoteClass)){
//                            Rectangle()
//                                .fill(Color.blue)
//                                .frame(width: 70, height: 80)
//                        }
//                    }
//
//
//
//        }
//    }
//                      }}}
//
struct Grid: View {
    //@ObservedObject var noteClass: NoteClass
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
                        // Use AsyncImage to load and display the image
                        NavigationLink(destination: ViewNotePhoto(entry: entry, noteVM: noteVM)) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)
                            .cornerRadius(8)
                        }
                    } else {
                        // If there is no image, show a placeholder
                        NavigationLink(destination: ViewNotePhoto(entry: entry, noteVM: noteVM)) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 120, height: 120)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}
