//
//  SplashScreenView.swift
//  M_M_App
//
//  Created by Mariana Laic on 2023-10-25.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var db = DbConnection()
    @EnvironmentObject var themeColor: ThemeColor

    @State var rotationAngle: Double = 0.0
    @State var size: Double = 0.1
    @State var opacity: Double = 0.6
    @State var isActive = false
    @State var currentUser: UserData? 
    
   
    
    var body: some View {
        ZStack{
            
            themeColor.colorSchemeMode().ignoresSafeArea()
       
            VStack {
                Image("cameraIcon")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(rotationAngle))
                    .scaleEffect(size)
                    .opacity(opacity)
            }
            .onAppear {
                triggerSplashAnimation()
            }
            .onChange(of: db.currentUser) { _ in
                triggerSplashAnimation()
            }
            .fullScreenCover(isPresented: $isActive) {
                
                if db.currentUser != nil {
                    NavigationStack {
                        ZStack {
                            themeColor.colorSchemeMode().ignoresSafeArea()
                            themeColor.themeFormCircle()
                            themeColor.themeFormRoundenRectangle()
                            
                            MainView()
                        }
                    }
                } else {
                    NavigationStack {
                        ZStack {
                            themeColor.colorSchemeMode().ignoresSafeArea()
                            themeColor.themeFormCircle()
                            themeColor.themeFormRoundenRectangle()
                            
                            LoginView()
                        }
                    }
                }
                
            }
            
            
        }
    }
    
    private func triggerSplashAnimation() {
        // Reset animation properties
        rotationAngle = 0.0
        size = 0.1
        opacity = 0.6
        isActive = false
        
        // Start the animation
        withAnimation(Animation.linear(duration: 2).repeatCount(1, autoreverses: false)) {
            rotationAngle = 365.0
            size = 2.5
            opacity = 1.0
        }
        
        // Delay the state change to trigger the navigation
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            isActive = true
        }
    }
    }
    
