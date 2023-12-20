//
//  MenuList.swift
//  OrderApp
//
//  Created by FDCI on 11/24/23.
//

import SwiftUI

struct MenuList: View {
    @StateObject var viewModel = AppetizerListViewModel()
    @State private var isShowingDetail = false
    @State private var selectedAppetize : Appetizer?
    var body: some View {
        ZStack{
            NavigationView{
                List(viewModel.appetizers){ appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .onTapGesture {
                            isShowingDetail = true
                            selectedAppetize = appetizer
                        }
                    
                }.navigationTitle("Appetizers")
            }.onAppear{
                print("On Appear")
                viewModel.getAppetizer()
            }
            .blur(radius: isShowingDetail ? 20: 0)
            .disabled(isShowingDetail)
            if viewModel.isloading {
                LoadingView()
            }
            if isShowingDetail {
                UpdateMenu(appetizer: selectedAppetize!, isShowingDetail: $isShowingDetail)
            }
            
            
            
        }
        .onChange(of: isShowingDetail) { newValue in
            print(newValue)
                        if !newValue {
                            viewModel.getAppetizer()
                        }
                    }
        .alert(item: $viewModel.alertItem){ alertItem in
            Alert(title: alertItem.title,message: alertItem.message,dismissButton: alertItem.dismessButton)
        }
        
    }
}

#Preview {
    MenuList()
}
