//
//  ContentView.swift
//  OrderApp
//
//  Created by FDCI on 11/6/23.
//

import SwiftUI
struct AppetizerTabView: View {
    @AppStorage("isAdmin") var isAdmin: Bool?
    var body: some View {
        TabView{
            
            AppetizerListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Acount")
                }
            OrderView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Order")
                }
//            HistoryView()
//                .tabItem {
//                    Image(systemName: "list.clipboard.fill")
//                    Text("History")
//                }
            AddMenu()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Add Menu")
                }
            MenuList()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Menu List")
                }
            
        }
        .accentColor(Color(.brandPrimary))
    }
}

#Preview {
    AppetizerTabView()
}
