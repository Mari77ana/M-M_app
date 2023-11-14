//
//  LoginView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-20.
//

import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    
    @EnvironmentObject var db: DbConnection
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
                VStack {
                    
                  
                    
//                    Text("LensLog")
//                        .font(.custom("AndThenItEnds", size: 40)
//                            )
//                    
//                        .italic()
//                        //.shadow(color: .black, radius: 1, x: 0, y: 1)
//                        .padding(.top,100)
//                        
//                        
//                        .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
//                        .background(
//                            
//                           Circle()
//                                
//                                   .foregroundColor(.yellow)
//                                   .offset(y: 45) // Adjust the 'y' value to move the circle down
//                                
//                           )
//                   
//                    Image("cameraIcon")
////                    Image(systemName: "person")
////                        .resizable()
////                        .frame(width: 50, height: 50)
////                        .foregroundStyle(.green)
//                        
//                        
//                       // .padding()
//                    
                    ZStack {
                        
                      
                        // Circle and Image as the background
                        Circle()
                            .foregroundColor(.yellow)
                            .frame(width: 200, height: 200)
                            .padding(.top,100)
                            .padding(.bottom,-20)
                           
                                Image("cameraIcon")
                                   
                                    .resizable()
                                    .scaledToFit()
                                   // .opacity(0.5)
                                    .frame(width: 75, height: 75)
                                    .offset(y: 100)
                      
                        Text("LensLog")
                            .font(.custom("AndThenItEnds", size: 55))
                            .italic()
                            .offset(y: -15)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
//                            .shadow(color: themeColor.isDarkModeEnabled ? .black : .green, radius: 1, x: 0, y: 1)
                            .padding(.top, 100)
                    }
                    
                    VStack(spacing: 45){
                        TextField("Enter your email", text: $email)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.gray : Color.black)
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                        
                        SecureField("Enter your password", text: $password)
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                        
                        
                        // Login Button
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
                   
                        
                        /// Go to Register
                        NavigationLink(destination: {
                            RegisterView(db: db)
                        }, label: {
                            HStack(spacing: 10){
                                Text("Don't have an account?")
                                    .foregroundStyle(.indigo)
                                Text("Sign Up!").bold()
                                    .foregroundStyle(.indigo)
                            }
                           
                        })
                        
                    }.padding(30)
                    Spacer()
                    
                }.padding()
                .customAlert(isPresented: $showAlert, title: "Alert", message: alertMessage)
            
    }// Body Ends
    
}// Content Ends





        
  
struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
            .environmentObject(DbConnection())
            .environmentObject(ThemeColor())
    }
    
}


