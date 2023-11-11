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
    @EnvironmentObject var themeColor: ThemeColor
    
    //var db = Firestore.firestore()
    @State var email = ""
    @State var password = ""
    @State private var showAlert = false
    @State var alertMessage = ""
    @State var showMainView = false
    
   
    
    
    
    func loginSuccess(email: String, password: String, completion: @escaping (Bool) -> Void) {
        if !email.isEmpty && !password.isEmpty {
            db.LoginUser(email: email, password: password) { success in
                /// Här kan du anropa din anpassade avslutningshanterare
                completion(success)
            }
        } else {
            /// Om e-post och lösenord inte är ifyllda, antar vi att inloggningen misslyckades
            completion(false)
        }
    }
       


    var body: some View {
        NavigationStack{
            ZStack{
                themeColor.colorSchemeMode().ignoresSafeArea()
                themeColor.themeFormCircle()
                themeColor.themeFormRoundenRectangle()
                
                VStack {
                    Text("LOGIN")
                        .font(.largeTitle)
                        .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
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
                            loginSuccess(email: email, password: password) { success in
                                if success {
                                    print("User ID: \(db.currentUser?.uid ?? "No user ID")")
                                    print("ONBOARD")
                                    alertMessage = "Onboard"
                                    showAlert = true
                                } else {
                                    DispatchQueue.main.async {
                                        print("Not onboard")
                                        alertMessage = "Failed login"
                                        showAlert = true
                                    }
                                }
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
            .customAlert(isPresented: $showAlert, title: "Alert", message: alertMessage)
            
        }/// ZStack Ends
            
    }// Body Ends
    
}// Content Ends





        
  
struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(db: DbConnection()).environmentObject(ThemeColor())
    }
    
}


