//
//  ContentView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import SwiftUI
import FirebaseFirestore



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








           
    











