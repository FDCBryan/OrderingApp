//
//  Order.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import SwiftUI
struct orderItem :Decodable, Identifiable{
    var id: Int
    var Item:Appetizer
    var count: Int
    var totalCost: Double {
        return Item.price * Double(count)
    }
    func copy() -> orderItem {
        return orderItem(id: id, Item: Item, count: count)
    }
}

struct orderList :Decodable, Identifiable{
    
    var id: Int
    var url: String
}

struct OrderHistoryItem: Identifiable {
    var id = UUID()
    var order: Order
    var date: Date
}


