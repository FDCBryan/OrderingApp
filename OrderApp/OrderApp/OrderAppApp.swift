//
//  OrderAppApp.swift
//  OrderApp
//
//  Created by FDCI on 11/6/23.
//

import SwiftUI

@main
struct OrderAppApp: App {
    var order = Order()
    var orderHistory = OrderHistory()
    @AppStorage("Islogin") var Islogin = false
    @AppStorage("isAdmin") var isAdmin = false
    var body: some Scene {
        WindowGroup {
            if Islogin{
                AppetizerTabView()
                    .environmentObject(order)
                    .environmentObject(orderHistory)
            }
            else{
                
                LoginView()
            }
        }
    }
}
