//
//  JournalEntry.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-19.
//

import Foundation
struct JournalEntry: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}
