//
//  HistoryView.swift
//  OrderApp
//
//  Created by FDCI on 11/16/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var orderHistory: OrderHistory
    var body: some View {
        List {
            ForEach(orderHistory.orderHistory) { historyEntry in
                
                VStack(alignment: .leading) {
                    ForEach(historyEntry.order.Items) { items in
                        Text("Item    :\(items.Item.name)")
                        Text("Price   :\(items.Item.price)")
                        Text("Order   :\(items.count)")
                        Text("SubTotal:\(items.totalCost)")
                        
                    }
                    Divider()
                    Text("Total : \(historyEntry.order.totalPrice)")
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2)) // Optional background color
                .cornerRadius(10) // Optional corner radius
            }
        }
        
        if orderHistory.orderHistory.isEmpty{
            EmptyState(imageName: "empty-order", message: "No Order Placed")
        }
    }
}
    
//    #Preview {
//        HistoryView()
//    }
