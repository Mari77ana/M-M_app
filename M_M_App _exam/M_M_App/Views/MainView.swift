//
//  MainView.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-18.
//


import SwiftUI

struct MainView : View {
    
    @StateObject var myJournal = Journal()
    
    @State var showPopUp = false
    var body: some View{
       
            
          
        NavigationStack{
            ZStack{
                VStack{
                   HStack(spacing: 20){
                       Image(systemName: "person")
                       Text("Username")

                   }.padding(.trailing,180).padding(.bottom,150)
                   Spacer()
                    
                    Grid(journal:myJournal)

                   Spacer()
                    Button(action: {showPopUp = true}, label: {Text("Add")
                        
                    })
            
            }
                if showPopUp {
                AddNotePhoto(journal: myJournal, showPopUp: $showPopUp)
            }
            }
        }
       
    }
}

struct Grid: View{
    
    var journal: Journal
    
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
                      content: { ForEach(journal.getEntries()){
                entry in
                NavigationLink(destination: ViewNotePhoto(entry: entry)){
                    Rectangle().frame(width: 70, height: 80, alignment: .center)
                    
                }}})
            
           
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
    
}
