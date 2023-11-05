//
//  ListRestaurantView.swift
//  FirebaseIntro_2023
//
//  Created by Mariana Laic on 2023-11-04.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct ListRestaurantView: View {
    
    @State var restaurants = [Restaurant]()
    
    var body: some View{
        
        NavigationStack{
            VStack{
                Text("Restaurants").bold().font(.title).padding()
                
                List(){// Visa restaurangens namn
                    ForEach(restaurants){ restaurant in
                        Text(restaurant.name)
                        
                    }
                }
                
            }
        }
        
    }
    
 
    
    
}

#Preview {
    ListRestaurantView() 
}




