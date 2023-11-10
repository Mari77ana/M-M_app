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
    @EnvironmentObject var dbConnection: DbConnection
    @EnvironmentObject var themeColor: ThemeColor
    
    @State var showPopUp = false
  
    
    func startListeningToDb(){ /// Funktionen skulle kunna flyttas till Dbonnection, är en Model
    
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
                themeColor.colorSchemeMode().ignoresSafeArea()
                themeColor.themeFormCircle()
                themeColor.themeFormRoundenRectangle()
                
                
                VStack{
                    HStack(spacing: 10){ ///20 var innan
                        Image(systemName: "person")
                        
                        Text(dbConnection.currentUserData?.firstname ?? "username")
                        
                        
                        
                    }.padding(.trailing,250) ///180, flytttade in den lite
                    Spacer()
                    ZStack{
                        Grid(noteClass: myNoteClass).frame(height: 380)
                    }
                    Spacer()
                    Button(action: {showPopUp = true}, label: {Text("Add")}).padding()
                   
                    
                    if showPopUp{
                        AddNote(note: myNoteClass)
                    }
                    
                    
                    Button(action: {
                        dbConnection.signOut()
                        
                    }, label: {Text ("Log out")})
                    
                    
               
                    
                }
                .sheet(isPresented: $showPopUp, content: {AddNote(note: myNoteClass)
                        .environmentObject(dbConnection)
                })
            }
            
        }.onAppear(perform: startListeningToDb)
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
            .environmentObject(DbConnection())
            .environmentObject(ThemeColor())
    }
    
}
