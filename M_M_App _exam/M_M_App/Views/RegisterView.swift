//
//  RegisterView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-14.
//

import SwiftUI


struct RegisterView: View {
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var comfirmPassword = ""
    
    var body: some View {
        VStack(){
            Text("REGISTER").font(.largeTitle)
           
            VStack(spacing: 45){
                TextField("Enter your Firstname", text: $firstname)
                    .padding(10)
                    .frame(width: 350, height: 40)
                    .border(.black)
                
                TextField("Enter your Lastname", text:$lastname )
                    .padding(10)
                    .frame(width: 350, height: 40)
                    .border(.black)
                
                TextField("Enter your Email", text: $email)
                    .padding(10)
                    .frame(width: 350, height: 40)
                    .border(.black)
                
                SecureField("Enter your password", text:$password )
                    .padding(10)
                    .frame(width: 350, height: 40)
                    .border(.black)
                
                SecureField("Confirm password", text:$password )
                    .padding(10)
                    .frame(width: 350, height: 40)
                    .border(.black)
                
                Button(action: {}, label: {
                    Text("Confirm")
                        .frame(width: 350, height: 45)
                        .background(.indigo)
                        .foregroundStyle(.white)
                        .cornerRadius(30)
                })
                Spacer()
                
            }.padding(50)
        }.padding(.top, 80)
        
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    
    static var previews: some View {
        RegisterView()
    }
    
}
