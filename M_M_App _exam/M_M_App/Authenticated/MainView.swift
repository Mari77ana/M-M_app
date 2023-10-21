//
//  MainView.swift
//  M_M_App
//
//  Created by Ana Marojevic on 2023-10-18.
//


import SwiftUI

struct MainView : View {
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack(spacing: 20){
                    Image(systemName: "person").foregroundColor(.white)
                 
                    Text("Username").foregroundStyle(.white)
                   
                }.padding(.trailing,180)
                
                Spacer()
                
            }
        }
       
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
    
}
