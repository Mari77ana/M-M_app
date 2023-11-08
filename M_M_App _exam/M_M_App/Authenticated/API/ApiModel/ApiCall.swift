//
//  ApiCall.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-11-08.
//

import Foundation


class ApiCall {
    
    /// Api call request, returns response advice
    func fetchAdvice(endpoint: String) async throws -> String {
        
        guard let url = URL(string: endpoint) else{throw ApiErrors.invalidURL}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let adviceResponse = try decoder.decode(AdviceResponse.self, from: data)
        
        return adviceResponse.slip.advice
    }
    
    
    
    
    

    
    
    ///  Errors Feedback
    enum ApiErrors: Error {
        
        case invalidURL
        case invaldResponse
        case invalidData
    }
    
    
    
    
}
