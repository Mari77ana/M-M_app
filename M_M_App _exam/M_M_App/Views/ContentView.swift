//
//  ContentView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    var db = Firestore.firestore()
    @State var email = ""
    
    var body: some View {
        
        NavigationStack{
            VStack {
                Text("LOGIN").font(.largeTitle)
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.green)
                    .padding(30)
                Spacer()
                
                VStack(spacing: 45){
                    TextField("Enter your email", text: $email)
                        .padding(10)
                        .frame(width: 350, height: 40)
                        .border(.black)
                    
                    SecureField("Enter your password", text: $email)
                        .padding(10)
                        .frame(width: 350, height: 40)
                        .border(.black)
                    
                    Button(action: {}, label: {
                        Text("Login")
                            .frame(width: 350, height: 45)
                            .background(.indigo)
                            .foregroundStyle(.white)
                            .cornerRadius(30)
                    })
                    Spacer()
                
                    NavigationLink(destination: {
                        RegisterView(username: "") // För att den ska vara tyst
                    }, label: {
                        HStack(spacing: 10){
                            Text("Don't have an account?")
                            Text("Sign Up!").bold()
                        }
                    })
                    
                    
                }.padding(60)
                
                
            }.padding(.top, 70)
            
        }
    }// Body Ends
    
}// Content Ends

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
