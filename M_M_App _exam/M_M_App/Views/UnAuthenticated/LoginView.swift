//
//  LoginView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-20.
//

import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    @ObservedObject var db: DbConnection
    
    //var db = Firestore.firestore()
    @State var email = ""
    @State var password = ""
 
    
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
                    
                    SecureField("Enter your password", text: $password)
                        .padding(10)
                        .frame(width: 350, height: 40)
                        .border(.black)
                    
                    Button(action: {
                        
                        if !email.isEmpty && !password.isEmpty {
                            // Create Login
                           
                        }
                       
                    }, label: {
                        Text("Login")
                            .frame(width: 350, height: 45)
                            .background(.indigo)
                            .foregroundStyle(.white)
                            .cornerRadius(30)
                    })
                    
                    Spacer()
                
                    NavigationLink(destination: {
                        RegisterView(db: db)
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
        
  
struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
       LoginView(db: DbConnection())
    }
    
}




// Nya filer skapas med nya versionen
/*
 #Preview {
 LoginView(db: DbConnection())
 }
 */
