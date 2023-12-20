//
//  AppetizerListView.swift
//  OrderApp
//
//  Created by FDCI on 11/6/23.
//

import SwiftUI

struct AppetizerListView: View {
    
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
                viewModel.getAppetizer()
                print("appear")
            }
            
            .blur(radius: isShowingDetail ? 20: 0)
            .disabled(isShowingDetail)
            if viewModel.isloading {
                LoadingView()
            }
            if isShowingDetail {
                AppetizerDetailView(appetizer: selectedAppetize!, isShowingDetail: $isShowingDetail)
            }
            
        }
        .alert(item: $viewModel.alertItem){ alertItem in
            Alert(title: alertItem.title,message: alertItem.message,dismissButton: alertItem.dismessButton)
        }
        
    }
    
    
}

#Preview {
    AppetizerListView()
}
