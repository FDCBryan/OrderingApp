//
//  AppetizerListCell.swift
//  OrderApp
//
//  Created by FDCI on 11/9/23.
//

import SwiftUI

struct AppetizerListCell: View {
    var appetizer : Appetizer
    var body: some View {
        HStack{
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120,height: 90)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing:10){
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("$\(appetizer.price, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.red)
            }.padding(.leading)
        }
    }
}

#Preview {
    AppetizerListCell(appetizer: Mockata.sampleAppetizer)
}
