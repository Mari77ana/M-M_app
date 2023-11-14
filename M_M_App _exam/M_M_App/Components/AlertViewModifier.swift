//
//  AlertViewModifier.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-23.
//

import Foundation
import SwiftUI


// * ViewModifier -> Protocol describes that an Alert can be cutomized to take in an AlertDialog


struct AlertViewModifier: ViewModifier{
    
    @Binding var isPresented: Bool
    let title: String
    let message: String
    
    func body(content: Content) -> some View {
        ZStack{
            
            content
            if isPresented{
                AlertView(isPresented: $isPresented, title: title, message: message)
            }

            
        }// ENDS Z
    }
    
    
}





//  With  self.modifier -> implements an AlertViewModifier
extension View{
    func 
    customAlert(isPresented: Binding<Bool>, title: String, message: String) -> some View{
        
        self.modifier(AlertViewModifier(isPresented:isPresented, title: title, message: message))
    
        
    }
    
}
