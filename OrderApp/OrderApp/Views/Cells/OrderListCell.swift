//
//  OrderListCell.swift
//  OrderApp
//
//  Created by FDCI on 11/16/23.
//

import SwiftUI

struct OrderListCell: View {
    var appetizer : Appetizer
    @State  var orderCount : Int = 1
    @State  var subTotal : Double = 1
    var body: some View {
        VStack {
            HStack{
                AppetizerRemoteImage(urlString: appetizer.imageURL)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120,height: 90)
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing:10){
                    Text(appetizer.name)
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Price: $\(appetizer.price, specifier: "%.2f")")
                        .font(.title3)
                        .foregroundColor(.red)
                    Text("Order: \(orderCount)")
                        .font(.title3)
                        .foregroundColor(.red)
                    Divider()
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Total: $\(subTotal, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }.padding(.leading)
            }
        }
    }
}

#Preview {
    OrderListCell(appetizer: Mockata.sampleAppetizer, orderCount: 1, subTotal: 100)
}
