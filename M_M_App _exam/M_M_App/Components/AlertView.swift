//
//  AlertView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-22.
//

import SwiftUI



// * STYLES THE ALERT *

struct AlertView: View {
    
    
     @Binding var isPresented: Bool
   // @Binding var isPresented: Bool
    let title: String
    let message: String
    
    var body: some View {
        
        if isPresented{
            
            ZStack{
                Color.black.opacity(0.5).ignoresSafeArea()
                
                VStack{
                    Text(title)
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                        .padding()
                    Text(message)
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                    Button( action: {
                        isPresented = false
                    }){
                        Text("OK")
                    }.padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
                .frame(width: 300, height: 250)
                .background(.gray)
                .cornerRadius(16)
                .padding()
                
                
            }
            
            
            
        }
    
        
        
    }
         
}


struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(isPresented: .constant(true), title: "Test Alert", message: "Detta är ett testmeddelande.")
    }
}









