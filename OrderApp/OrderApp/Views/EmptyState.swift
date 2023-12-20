//
//  EmptyState.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import SwiftUI

struct EmptyState: View {
    var imageName: String
    var message: String
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Text(message)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
                
            }.offset( y: -10)
        }
    }
}

#Preview {
    EmptyState(imageName: "empty-order", message: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..")
}
