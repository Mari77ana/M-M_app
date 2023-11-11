//
//  ThemeColor.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-11-10.
//

import Foundation
import SwiftUI

class ThemeColor: ObservableObject {
    
    @Published var isDarkModeEnabled = false
    
    
    
    ///    * Dark Mode
    func colorSchemeMode() -> Color {
        
        if isDarkModeEnabled {
            return Color("darkModeBackground")
        }else{
            return Color(.white)
        }
    }
    
    
    ///  * Circle *
    func themeFormCircle() -> some View {
        
        Circle()
            .frame(width: 270)
            .offset(x: 150, y: -420)
            .foregroundColor(isDarkModeEnabled ? Color.lightBlack : Color.green )
            .blur(radius: 5)
    }
    
    
    
    ///  * Roundedrectangle *
    func themeFormRoundenRectangle() -> some View {
        
        RoundedRectangle(cornerRadius: 630, style: .continuous)
            .frame(width: 130, height: 270)
            .rotationEffect(.degrees(135))
            .offset(x: -140, y: 390)
            .foregroundColor(isDarkModeEnabled ? Color.darkGray : Color.blue)
            .blur(radius: 5)
        
    }
    
  
   
    
    
}
