//
//  MainView.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-18.
//


import SwiftUI
import FirebaseFirestore

struct MainView : View {
    var db = Firestore.firestore()
    @StateObject var myNoteClass = NoteClass()
    @State var showPopUp = false
    @EnvironmentObject var dbConnection: DbConnection
    
    func startListeningToDb(){
    
        guard let currentUser = dbConnection.currentUser else {return}
        
        db.collection("user_data").document(currentUser.uid).collection("notes").addSnapshotListener{
             snapshot, error in
             
             if let error = error {
                 print("error occured \(error.localizedDescription)")
                 return
             }
             //if we havent received any error then the snapshot has received a value
             guard let snapshot = snapshot else{return}
             
            
             for document in snapshot.documents{
                 let result = Result {
                     try document.data(as: Note.self)
                 }
                 
                 switch result {
                 case .success(let note):
                    
                         self.myNoteClass.addEntry(entry: note)
                    
                         print(note.titel)
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
         }
     }
    
    var body: some View{
        NavigationStack{
            ZStack{
                
                VStack{
                    HStack(spacing: 20){
                        Image(systemName: "person")
                        
                        Text("Username")
                        
                        
                        
                    }.padding(.trailing,180)
                    ZStack{
                        Grid(noteClass: myNoteClass)
                    }
                    Button(action: {showPopUp = true}, label: {Text("Add")}).padding()
                   
                    
                    if showPopUp{
                        AddNote(note: myNoteClass, showPopUp: $showPopUp
                                )
                    }
                    
                    
                    Button(action: {
                        dbConnection.signOut()
                        
                    }, label: {Text ("Log out")})
                    
                    
                    Spacer()
                    
                }
                .sheet(isPresented: $showPopUp, content: {AddNote(note: myNoteClass, showPopUp: $showPopUp)
                        .environmentObject(dbConnection)
                })
            }
            
        }.onAppear(perform: startListeningToDb)
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView().environmentObject(DbConnection())
    }
    
}
