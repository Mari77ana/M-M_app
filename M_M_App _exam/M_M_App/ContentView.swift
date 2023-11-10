//
//  ContentView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @StateObject var db = DbConnection()
    @State var showSplashScreen = true
    // Börja från SplashScreen
    
    var body: some View {
        
        
        if let user = db.currentUser {
            NavigationStack{
                
                VStack{
                    /// Börja fr SplashScreen
                    if let user = db.currentUser{
                        if showSplashScreen{
                            SplashScreenView()
                            /// onAppear in need to show SplashScreen again for 0.5 sek
                                .onAppear{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ){
                                        showSplashScreen = false
                                    }
                                }
                        }else{
                            MainView().environmentObject(db)
                        }
                    }else{
                        NavigationStack{
                            //LoginView(db: db)
                            SplashScreenView()
                        }
                    }
                    
                }
            }
            
            
        }
        else{
            NavigationStack{
               // LoginView(db: db)
                SplashScreenView()
            }
            
            
            
        }
    }
    
}
    struct ContentView_Previews: PreviewProvider {
        
        static var previews: some View {
            ContentView()
        }
        
    }
