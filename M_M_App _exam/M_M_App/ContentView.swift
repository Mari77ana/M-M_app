//
//  ContentView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import SwiftUI
import FirebaseFirestore

//struct ContentView: View {
//    
//    @StateObject var db = DbConnection()
//    @State var showSplashScreen = true
//    @EnvironmentObject var themeColor: ThemeColor
//    // Börja från SplashScreen
//    
//    var body: some View {
//        
//        
//        if let user = db.currentUser {
//            NavigationStack{
//                
//                VStack{
//                    /// Börja fr SplashScreen
//                    if let user = db.currentUser{
//                        if showSplashScreen{
//                            SplashScreenView().environmentObject(themeColor)
//                            /// onAppear in need to show SplashScreen again for 0.5 sek
//                                .onAppear{
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ){
//                                        showSplashScreen = false
//                                    }
//                                }
//                        }else{
//                            MainView().environmentObject(db).environmentObject(themeColor)
//                        }
//                    }else{
//                        NavigationStack{
//                         
//                            SplashScreenView()
//                        }
//                    }
//                    
//                }
//            }
//            
//            
//        }
//        else{
//            NavigationStack{
//            
//                SplashScreenView()
//            }
//            
//            
//            
//        }
//    }
//    
//}
//    struct ContentView_Previews: PreviewProvider {
//        
//        static var previews: some View {
//            ContentView()
//        }
//        
//    }
struct ContentView: View {
    
    @StateObject private var dbConnection = DbConnection()
    
    @StateObject var themeColor = ThemeColor()  /// Instansiate here for lifecycle and to get access from themeColor to all views
    
    var body: some View {

        SplashScreenView()
            .environmentObject(dbConnection)
            .environmentObject(themeColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ThemeColor())
    }
}







/*
if let user = db.currentUser {
    NavigationStack{
        
        VStack{
            /// Börja fr SplashScreen
            if let user = db.currentUser{
                if showSplashScreen{
                    SplashScreenView().environmentObject(themeColor)
                    /// onAppear in need to show SplashScreen again for 0.5 sek
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ){
                                showSplashScreen = false
                            }
                        }
                }else{
                    MainView().environmentObject(db).environmentObject(themeColor)
                }
            }else{
                NavigationStack{
                    LoginView(db: db).environmentObject(themeColor)
                    //SplashScreenView()
                }
            }
            
        }
    }
    
    
}
else{
    NavigationStack{
        LoginView(db: db)
       // SplashScreenView()
    }
}
*/











