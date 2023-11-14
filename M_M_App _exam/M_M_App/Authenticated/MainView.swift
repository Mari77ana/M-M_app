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
    
  //  @StateObject var myNoteClass = NoteClass()
    @StateObject var notesVM = NotesViewModel()
    @EnvironmentObject var dbConnection: DbConnection
    @EnvironmentObject var themeColor: ThemeColor
    
    @State var showPopUp: Bool = false
    @State var animate: Bool = false
    
//    func startListeningToDb(){ /// Funktionen skulle kunna flyttas till Dbonnection, är en Model
//    
//        guard let currentUser = dbConnection.currentUser else {return}
//        
//        db.collection("user_data").document(currentUser.uid).collection("notes").addSnapshotListener{
//             snapshot, error in
//             
//             if let error = error {
//                 print("error occured \(error.localizedDescription)")
//                 return
//             }
//             //if we havent received any error then the snapshot has received a value
//             guard let snapshot = snapshot else{return}
//             
//            
//             for document in snapshot.documents{
//                 let result = Result {
//                     try document.data(as: Note.self)
//                 }
//                 
//                 switch result {
//                 case .success(let note):
//                    
//                         self.myNoteClass.addEntry(entry: note)
//                    
//                         print(note.titel)
//                 case .failure(let error):
//                     print(error.localizedDescription)
//                 }
//             }
//         }
//     }
    
    var body: some View{
                    VStack{
                        
                        HStack(){ ///20 var innan spacing: 10
                            
                            
                            /// Logout Button
                            Button(action: {
                                dbConnection.signOut()
                                
                            }, label:
                                    {Text ("Log out")
                                    .font(.headline)
                            })
                            //.padding(.top, -20) //.top, -30
                            .zIndex(1)
                            
                            
                            Spacer()
                            
                            ///  DarkMode Button
                            Button(action: {
                                themeColor.isDarkModeEnabled.toggle()
                            }, label: {
                                Image(systemName: themeColor.isDarkModeEnabled ? "sun.max.fill" : "moon.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30) // Adjust the frame as needed
                                //.padding(.bottom, 30)
                            })
                            .zIndex(1)
                            
                        }//.padding(.trailing,230) ///180
                        //.padding(.horizontal, 10)
                        .padding()
                        .overlay(
                            Rectangle().frame(width: 393, height: 125)
                                .foregroundColor(.gray)
                                .opacity(0.3)
                                .ignoresSafeArea()
                            
                        )
                        ZStack{
                            

                            Circle()
                                .foregroundColor (.yellow)
                                .frame (width: 100, height: 100)
                                .padding (.bottom, 5)
                                .padding (.top,8)
                            Text (dbConnection.currentUserData?.firstname ??
                                  "username")
                            .font (.custom ("AndThenItEnds", size: 20))
                            // .offset (y: 4)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                        }
                        
                        /// Note Grid
                        Grid(noteVM: notesVM).frame(height: 380)
                        
                        
                        Spacer()
                        
                        
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
                    }.zIndex(5.0)
            .sheet(isPresented: $showPopUp, content: {AddNote( NoteVM: NotesViewModel())
                        .environmentObject(dbConnection)
                })
                .onAppear {if let userId = dbConnection.currentUser?.uid {
                    notesVM.startListeningToDb(foruserId: userId)
                }}
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
