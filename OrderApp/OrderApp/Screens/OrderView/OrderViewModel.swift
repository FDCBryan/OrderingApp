//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by FDCI on 11/23/23.
//

import SwiftUI


final class Order: ObservableObject, Identifiable{
    @Published var Items : [orderItem] = []
    @Published var isSafariViewPresented = false
    @Published var safariURL = ""
    var totalPrice: Double{
        Items.reduce(into: 0){
            $0 += $1.totalCost
        }
    }
    
    func captureState() -> Order {
        let copy = Order()
        copy.Items = self.Items.map { $0.copy() }
        return copy
    }
    
    func reset() {
        self.Items = []
    }
    func openSafari(order: Order){
        
        NetworkManager.share.pay(from: order){ result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let loggedInUser):
                    if !loggedInUser.data.attributes.checkoutUrl.absoluteString.isEmpty {
                        // The checkoutURL is not empty
                        let checkoutURL = loggedInUser.data.attributes.checkoutUrl.absoluteString
                        // Now you can use the urlString as a String
                        safariURL = checkoutURL
                        isSafariViewPresented = true
                    } else {
                    }
                case .failure(let error):
                    print(error)
                    //self.alertItem = AlertContext.unableToComplete
                }
            }
            
        }
        
    }
}



final class OrderHistory: ObservableObject {
    @Published var orderHistory: [OrderHistoryItem] = []
    
    func addOrderToHistory(order: Order) {
        let orderHistoryItem = OrderHistoryItem(order: order, date: Date())
        orderHistory.append(orderHistoryItem)
    }
}
