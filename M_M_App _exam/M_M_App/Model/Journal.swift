//
//  Journal.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-19.
//

import Foundation

class Journal: ObservableObject{
    @Published private var entries: [JournalEntry]
    init() {
        self.entries = [JournalEntry]()
        self.entries.append(JournalEntry(title: "Note 1", description: "Hello"))
        
    }
    
    func getEntries() -> [JournalEntry]{
        return entries
    }
    
    func addEntry(entry: JournalEntry){
        entries.append(entry)
    }
}
