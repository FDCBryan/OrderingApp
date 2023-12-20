//
//  AppetizerDetailView.swift
//  OrderApp
//
//  Created by FDCI on 11/10/23.
//

import SwiftUI

struct AppetizerDetailView: View {
    @EnvironmentObject var order: Order
    let appetizer :Appetizer
    @State  var orderCount : Int = 1
    @Binding  var isShowingDetail : Bool
    var body: some View {
        VStack{
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300,height: 225)
            
            VStack{
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(appetizer.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                HStack(spacing: 40){
                    NutritionDetails(value: appetizer.carbs, title: "Carbs")
                    NutritionDetails(value: appetizer.calories, title: "Calories")
                    NutritionDetails(value: appetizer.protein, title: "Protein")

                    
                }
                HStack {
                                Text("Quantity")
                                Spacer()
                                Text("\(orderCount)")
                            }
                            .padding()

                            Stepper("", value: $orderCount, in: 1...10, step: 1)
                                .labelsHidden()
                Spacer()
                Button{
                    order.Items.append(orderItem(id: Int.random(in: 1...100), Item: appetizer, count: orderCount))
                    isShowingDetail = false
                }label:{
                    OrderButton(text: "$\((appetizer.price * Double(orderCount)), specifier: "%.2f") - Order ")
                }
                
                .padding(.bottom)
                
                
            }
            Spacer()
        }
        .overlay(
            Button{
                isShowingDetail = false
            }label:{
                
                Xbutton()
            },alignment: .topTrailing
        
        )
        .frame(width: 300,height:  525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
    }
}

#Preview {
    AppetizerDetailView(appetizer: Mockata.sampleAppetizer, isShowingDetail: .constant(true))
}


struct NutritionDetails: View {
    var value: Int
    var title : String
    var body: some View {
        VStack(spacing: 5){
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            Text("\(value)").foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
