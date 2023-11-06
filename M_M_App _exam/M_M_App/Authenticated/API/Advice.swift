//
//  Advice.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-11-03.
//

import Foundation


struct AdviceResponse: Codable {
   
    let slip: Advice
    
}


struct Advice: Codable {
    
    var id: Int
    var advice: String
}
