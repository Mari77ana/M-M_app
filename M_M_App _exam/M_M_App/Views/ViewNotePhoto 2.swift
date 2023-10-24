//
//  ViewNotePhoto.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-19.
//

import SwiftUI

struct ViewNotePhoto: View {
    var entry: JournalEntry
    @ObservedObject var journal: Journal
    @State var isDeleted: Bool = false
    
    
   
    var body: some View {
        VStack{
            if !isDeleted {
                Text(entry.title)
                Text(entry.description)}
            Button(action:{
                journal.deleteEntry(byId: entry.id)
               isDeleted = true
               
            }, label: {
                Text("Delete")
                
            })
           
        }
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: JournalEntry(title: "hello", description: "description"), journal: Journal())
    }
}
