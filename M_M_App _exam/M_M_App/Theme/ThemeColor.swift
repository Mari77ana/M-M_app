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
    
    
    
    /// Function for Theme Color
    func colorSchemeMode() -> Color {
        
        if isDarkModeEnabled {
            return Color("darkModeBackground")
        }else{
            return Color(.white)
        }
    }
    
}
