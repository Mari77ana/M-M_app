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
    }
}

struct ViewNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotePhoto(entry: Note(titel: "hello", description: "hellooo"), journal: NoteClass())
    }
}
