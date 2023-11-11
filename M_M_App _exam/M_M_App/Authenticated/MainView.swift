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
                    Image("Frame 8-2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: -10)
                    
                    HStack(spacing: 10){ ///20 var innan spacing: 10
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 25,height: 25)
                            .foregroundColor(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                          
                            
                        Text(dbConnection.currentUserData?.firstname ?? "username")
                            .font(.title2)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                        
                        Spacer()
                        
                        
                        Button(action: {
                            themeColor.isDarkModeEnabled.toggle()
                        }, label: {
                            Text(themeColor.isDarkModeEnabled ? "LightMode" : "Dark Mode")
                        })
                       // .padding(.leading)
                      
                        
                        
                    }//.padding(.trailing,230) ///180
                    .padding(.horizontal, 25)
                    
                       
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
