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
    
   
    var body: some View {
        VStack{
            Text(entry.title)
            Text(entry.description)
            Button(action: {journal.deleteEntry(byId: entry.id)}, label: {Text("Delete")})
        }
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: JournalEntry(title: "hello", description: "description"), journal: Journal())
    }
}
