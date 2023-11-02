//
//  SplashScreenView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-25.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var rotationAngle: Double = 0.0
    @State var size: Double = 0.1
    @State var opacity: Double = 0.6
    @State var isActive = false
    
    
    var body: some View {
        
        if isActive {
            /// Navigate to LoginView
            LoginView(db: DbConnection())
        }else {
            
            VStack{
                Image("cameraIcon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(rotationAngle))
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(Animation.linear(duration: 2)
                            . repeatCount(2)){
                                rotationAngle = 365.0
                                self.size = 2.5
                                self.opacity = 1.0
                            }
                    }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    isActive = true
                }
            }
            
        }
     
        
        
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
       SplashScreenView()
    }
    
}
