//
//  AccountViewModel.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
    @AppStorage("UserID") var userID: Int?
    @Published var user = User1()
    @Published var alertItem : AlertItem?
    var isValidform:Bool{
        guard !user.name.isEmpty || !user.email.isEmpty else{
            alertItem = AlertContext.EmptyValue
            return false
        }
        guard user.email.isValidEmail else{
            alertItem = AlertContext.InvalidEmail
            return false}
        return true
    }
    
    func saveChanges(){
        guard isValidform else {return}
        NetworkManager.share.UpdateUser(name: user.name ,email: user.email , id: userID!) { result in
            DispatchQueue.main.async { [self] in
            switch result {
            case .success(let loggedInUser):
                if loggedInUser.id > 0 {
                    user = loggedInUser
                    alertItem = AlertContext.userSaveSuccess
                }else{
                }
            case .failure(_):
                print("error")
            }
        }
        }
        
        
    }
    
    
    func retrieveData(){
        
        print("This is the UserID \(userID!)")
                NetworkManager.share.fetchUserInfo(userId: userID!) { result in
                    DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let loggedInUser):
                        if loggedInUser.id > 0 {
                            user = loggedInUser
                        }else{
                        }
                    case .failure(_):
                        print("error")
                    }
                }
                }

    }
}
