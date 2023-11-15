//
//  AlertViewModifier.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-23.
//

import Foundation
import SwiftUI

// ViewModifier -> protocol wich describes how an Alert should be modified to include an AlertDialog

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

            
        }
    }
    
    
}
extension View{
    
    //   self.modifier is used to apply AlertViewModifier
    func
    customAlert(isPresented: Binding<Bool>, title: String, message: String) -> some View{
        
        self.modifier(AlertViewModifier(isPresented:isPresented, title: title, message: message))
    
        
    }
    
}
