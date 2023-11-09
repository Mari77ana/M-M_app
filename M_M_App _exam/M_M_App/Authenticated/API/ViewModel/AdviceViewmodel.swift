//
//  AdviceViewmodel.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-11-08.
//

import Foundation


class AdviceViewmodel: ObservableObject {
    
    let api = ApiCall()
    var adviceEndpoint = "https://api.adviceslip.com/advice"
    @Published var advice: String?
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    
    func fetchAdvice() async {
        
        /// Task = Makes sure that the call value is updated from Main Thread (via operators like recive),
        ///  DispatchQueue in need to make sure it comes from main Thread, (because i used @Published)
       
            
            do{
                let myAdvice = try await api.fetchAdvice(endpoint: adviceEndpoint)
                DispatchQueue.main.async {
                    self.advice = myAdvice
                }
                
            }catch ApiCall.ApiErrors.invalidURL{
                showErrorAlert =  true
                errorMessage = "Invalid URL"
                
            }catch ApiCall.ApiErrors.invaldResponse{
                showErrorAlert = true
                errorMessage = "Invalid Response"
                
            }catch{
                showErrorAlert = true
                errorMessage = "General Error"
            }
            
            
        
        
        
        
        
        
        
        
    }
    
    
}
