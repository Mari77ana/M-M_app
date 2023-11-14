//
//  RegisterView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import SwiftUI


struct RegisterView: View {
    
    @ObservedObject var db: DbConnection 
    @EnvironmentObject var themeColor: ThemeColor
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var comfirmPassword = ""

    

    
    var body: some View {
        NavigationStack{
            ZStack{
                themeColor.colorSchemeMode().ignoresSafeArea()
                themeColor.themeFormCircle()
                themeColor.themeFormRoundenRectangle()
                
                VStack(){
                    ZStack {
                    
                        // Circle and Image as the background
                        Circle()
                            .foregroundColor(.yellow)
                            .frame(width: 150, height: 150)
                            .padding(.top,100)
                            .padding(.bottom,-20)
                            .padding(.top,-80)
                           
                                Image("cameraIcon")
                                   
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55, height: 55)
                                    .offset(y: 60)
                      
                        Text("LensLog")
                            .font(.custom("AndThenItEnds", size: 45))
                            .italic()
                            .offset(y: -40)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.white : Color.black)
                            .padding(.top, 100)
                    }
                    
                    VStack(spacing: 45){
                        TextField("Enter your Firstname", text: $firstname)
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.gray : Color.black)
                        
                        TextField("Enter your Lastname", text:$lastname )
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.gray : Color.black)
                        
                        TextField("Enter your Email", text: $email)
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                            .foregroundStyle(themeColor.isDarkModeEnabled ? Color.gray : Color.black)
                        
                        SecureField("Enter your password", text:$password )
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                        
                        SecureField("Confirm password", text:$comfirmPassword)
                            .padding(10)
                            .frame(width: 350, height: 40)
                            .border(.black)
                            .cornerRadius(10)
                        
                        
                        Button(action: {
                            if !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !password.isEmpty && password == comfirmPassword {
                                
                                // Creates Account
                                let isSuccess = db.RegisterUser(firstname: firstname, lastname: lastname, email: email, password: password)
                                if !isSuccess {
                                    print("Faild to create account")
                                }
                                
                            }
                            
                            
                        }, label: {
                            Text("Confirm")
                                .frame(width: 350, height: 45)
                                .background(.indigo)
                                .foregroundStyle(.white)
                                .cornerRadius(30)
                        })
                        
                        
                        
                        Spacer()
                        
                    }.padding(50)
                }.padding(.top, 80)
                
            }/// ZStack Ends
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    
    static var previews: some View {
        RegisterView(db: DbConnection()).environmentObject(ThemeColor())
    }
    
}
