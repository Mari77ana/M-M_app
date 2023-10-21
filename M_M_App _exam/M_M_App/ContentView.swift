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
    
    
    var body: some View {
        
        if let user = db.currentUser{
            NavigationStack{
                VStack{
                    MainView()
                }
            }
            
            
        } else{
            NavigationStack{
                LoginView(db: db)
            }
           
        }
            
       
            
             
            
            
        
        
        
    }
    
    
}
    struct ContentView_Previews: PreviewProvider {
        
        static var previews: some View {
            ContentView()
        }
        
    }
