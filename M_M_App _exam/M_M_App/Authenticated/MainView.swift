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
    
  
    @StateObject var notesVM = NotesViewModel()
    @EnvironmentObject var dbConnection: DbConnection
    @EnvironmentObject var themeColor: ThemeColor
    
    @State var showPopUp: Bool = false
    @State var animate: Bool = false
    
    var body: some View{
        
                    VStack{
                        
                        HStack(){
                            
                            // Logout Button
                            Button(action: {
                                dbConnection.signOut()
                                
                            }, label:
                                    {Text ("Log out")
                                    .font(.headline)
                            })
                            .zIndex(1)
                            
                            Spacer()
                            
                            //  DarkMode Button
                            Button(action: {
                                themeColor.isDarkModeEnabled.toggle()
                            }, label: {
                                
                                Image(systemName: themeColor.isDarkModeEnabled ? "sun.max.fill" : "moon.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            })
                            .zIndex(1)
                        }
                        .padding()
                        
                        .overlay(
                            
                            Rectangle().frame(width: 393, height: 125)
                                .foregroundColor(.gray)
                                .opacity(0.3)
                                .ignoresSafeArea()
                            
                        )
                        
                        ZStack{
                            
                            //font till username
                            Circle()
                                .foregroundColor (.yellow)
                                .frame (width: 100, height: 100)
                                .padding (.bottom, 5)
                                .padding (.top,8)
                            Text (dbConnection.currentUserData?.firstname ??
                                  "username")
                            .font (.custom ("AndThenItEnds", size: 20))
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                        }
                        
                        // Note Grid
                        Grid(noteVM: notesVM).frame(height: 380)
                        
                        Spacer()
                        
                        //  Animatet Button
                        Button(action: {
                            showPopUp = true}, label: {
                                
                                ZStack{
                                    
                                    Circle().frame(width: 60)
                                        .foregroundColor(animate ? Color.indigo : Color.pink)
                                    Text("+").foregroundStyle(.black).font(.largeTitle)
                                }
                                
                            })
                        .padding(.horizontal, animate ? 30 : 50)
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
            }
        }
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
    }
    
    
}// View ends




struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
            .environmentObject(DbConnection())
            .environmentObject(ThemeColor())
    }
    
}
