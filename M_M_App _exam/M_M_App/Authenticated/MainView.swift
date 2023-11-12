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
    
    @State var showPopUp: Bool = false
    @State var animate: Bool = false
    
  
    
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
                    /// Img Person
                    HStack(){ ///20 var innan spacing: 10
                        
                     
                        
                       
                            /// Logout Button
                            Button(action: {
                                dbConnection.signOut()
                                
                            }, label: {Text ("Log out")
                            })
                            .padding(.top, -20) //.top, -30
                            .font(.headline)
                        
                          Spacer()
                            
                            ///  DarkMode Button
                            Button(action: {
                                themeColor.isDarkModeEnabled.toggle()
                            }, label: {
                                Image(systemName: themeColor.isDarkModeEnabled ? "sun.max.fill" : "moon.fill")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 30, height: 30) // Adjust the frame as needed
                                       .padding(.bottom, 30)
                            })
                            
                      
                        
                    }//.padding(.trailing,230) ///180
                    .padding(.horizontal, 10)
                    .padding()
                    .background(
                        Rectangle().frame(width: 393, height: 125)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .ignoresSafeArea()
                           
                    )
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .foregroundColor(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                        
                    /// Username
                    Text(dbConnection.currentUserData?.firstname ?? "username")
                        .font(.title)
                        .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                    
                    Spacer()
                  
                    ZStack{
                        Grid(noteClass: myNoteClass).frame(height: 380)
                    }
                    Spacer()
                    
                    if showPopUp{
                        AddNote(note: myNoteClass)
                    }
                        
                    
                    ///  Animatet Button
                    Button(action: {
                        showPopUp = true}, label: {
                          
                            ZStack{
                                Circle().frame(width: 60)
                                    .foregroundColor(animate ? Color.indigo : Color.pink)
                                Text("+").foregroundStyle(.black).font(.largeTitle)
                            }
                      
                    })//.padding(.bottom, 60)
                        .padding(.horizontal, animate ? 30 : 50)
                        //.scaleEffect(animate ? 1.1 : 1.0)
                        .background(
                           Rectangle().frame(width: 393, height: 133)
                                .foregroundColor(.gray)
                                .opacity(0.3)
                                .ignoresSafeArea()
                           
                    )
                }
                .sheet(isPresented: $showPopUp, content: {AddNote(note: myNoteClass)
                        .environmentObject(dbConnection)
                })
            }
            
        }.onAppear(perform: startListeningToDb)
        .onAppear(perform: addAnimation)
    }
    
    
    
    
    
    
    
    func addAnimation(){
        guard !animate else {return} /// In need because of onAppear so it wont toggle twice when switch screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
            Animation
                .easeInOut(duration: 2.0)
                .repeatForever()
            ) {
                animate.toggle()
            }
        }
    } /// function ends

 
    
}/// View ends

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
            .environmentObject(DbConnection())
            .environmentObject(ThemeColor())
    }
    
}
