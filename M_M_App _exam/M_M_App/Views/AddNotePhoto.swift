//
//  AddNotePhoto.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-19.
//

import SwiftUI

struct AddNotePhoto: View {
    
    @State var txtTitle = ""
    @State var txtDescription = ""
    @ObservedObject var journal:Journal
    @Binding var showPopUp: Bool
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                Text("Add entry").font(.title).bold().foregroundColor(.white).padding()
                
                VStack(alignment: .leading) {
                    Text("Ange titel").foregroundColor(.white)
                    TextField("", text: $txtTitle).textFieldStyle(.roundedBorder)
                    
                    Text("Ange beskrivning").foregroundColor(.white)
                    TextEditor(text: $txtDescription).cornerRadius(9)
                }.padding()
                
                VStack(spacing: 20) {
                    Button(action: {
                        let newEntry = JournalEntry(title: txtTitle, description: txtDescription
                        )
                        journal.addEntry(entry: newEntry)
                        showPopUp = false
                    }, label: {
                        Text("Save").padding().background(.white).foregroundColor(.black).bold().cornerRadius(9)
                    })
                    
                    Button(action: {
                        showPopUp = false
                    }, label: {
                        Text("Cancel").foregroundColor(.white)
                    })
                }.padding()
                
                
                Spacer()
            }
            .background(.brown)
            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.6, alignment: .center)
            .cornerRadius(9)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}



struct AddNotePhoto_Previews: PreviewProvider {
    static var previews: some View {
        AddNotePhoto(journal: Journal(),showPopUp: .constant(true))
    }
}
