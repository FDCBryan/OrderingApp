//
//  AppetizerListViewModel.swift
//  OrderApp
//
//  Created by FDCI on 11/9/23.
//

import Foundation

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] =  []
    @Published var alertItem: AlertItem?
    @Published var isloading = false
    func getAppetizer(){
        isloading = true
        NetworkManager.share.getAppetizer { [self] result in
            DispatchQueue.main.async { [self] in
                isloading = false
                switch result{
                case .success(let appetizers):
                    self.appetizers = appetizers
                case .failure(let error):
                    switch error{
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
 
        }
    }
}
