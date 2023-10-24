//
//  Grid.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import Foundation
import SwiftUI

struct Grid: View {
    
    @ObservedObject var noteClass: NoteClass
    
    let columns: [GridItem] = [
        
        GridItem(.fixed(50), spacing: 30, alignment: nil),
        GridItem(.fixed(50), spacing: 30, alignment: nil),
        GridItem(.fixed(50), spacing: 30, alignment: nil)
        
    ]
    var body: some View{
        
        
        ScrollView{
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 15,
                      pinnedViews: [],
                      content: { ForEach(noteClass.getNotes()){
                entry in
                NavigationLink(destination: ViewNotePhoto(entry: entry, journal: NoteClass())){
                    Rectangle().frame(width: 70, height: 80, alignment: .center)
                    
                    
                }}})
            
            
        }
    }
}
