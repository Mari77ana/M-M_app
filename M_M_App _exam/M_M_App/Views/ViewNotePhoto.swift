//
//  ViewNotePhoto.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-19.
//

import SwiftUI

struct ViewNotePhoto: View {
    var entry: JournalEntry
    var body: some View {
        VStack{
            Text(entry.title)
            Text(entry.description)
        }
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: JournalEntry(title: "i", description: "i"))
    }
}
