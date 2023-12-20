//
//  OrderView.swift
//  OrderApp
//
//  Created by FDCI on 11/6/23.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    @EnvironmentObject var orderHistory: OrderHistory
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List(){
                        ForEach(order.Items){appetizer in
                            OrderListCell(appetizer: appetizer.Item, orderCount: appetizer.count,subTotal: appetizer.totalCost)
                            
                        }.onDelete(perform: { indexSet in
                            order.Items.remove(atOffsets: indexSet)
                        })
                    }.listStyle(PlainListStyle())
                    
                    Button{
                        let capturedState = order.captureState()
                        orderHistory.addOrderToHistory(order: capturedState)
                        order.reset()
                        order.openSafari(order: capturedState)
                        
                    }label: {
                        OrderButton(text: "$\(order.totalPrice, specifier: "%.2f") Confirm Order")
                    }
                }
                
                if order.Items.isEmpty{
                    EmptyState(imageName: "empty-order", message: "No Order Placed")
                }
            }
            .fullScreenCover(isPresented: $order.isSafariViewPresented) {
                SafariView(url: URL(string: order.safariURL)!)
                        }
            .navigationTitle("Orders")
        }
    }
}

#Preview {
    OrderView()
}
