//
//  NoteClass.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-24.
//

import Foundation
class NoteClass:ObservableObject{
    @Published private var noteEntry:[Note]
    init() {
        self.noteEntry = [Note]()
        self.noteEntry.append(Note(titel: "Hello", description: "Description"))
    }
    
    func getNotes() -> [Note]{
        return noteEntry
    }
    
    func addEntry(entry: Note){
        if !noteEntry.contains(where: { $0.id == entry.id }) {
            noteEntry.append(entry)
        }
    }
    
    func deleteEntry(index: Int ){
        noteEntry.remove(at: index)
    }
}
