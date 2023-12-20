//
//  AccountView.swift
//  OrderApp
//
//  Created by FDCI on 11/6/23.
//

import SwiftUI

struct AccountView: View {
    @StateObject var AccountviewModel = AccountViewModel()
    @AppStorage("UserID") var UserID: Int?
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Personal Information")){
                    TextField("Name", text: $AccountviewModel.user.name)
                    TextField("Email", text: $AccountviewModel.user.email)

                    Button{
                        AccountviewModel.saveChanges()
                    }label: {
                        Text("Update")
                    }.padding(.top)
                }
            }
            .navigationTitle("Account")
        }
        .onAppear{
            AccountviewModel.retrieveData()
        }
        .alert(item: $AccountviewModel.alertItem){
            AlertItem in
            Alert(title: AlertItem.title, message: AlertItem.message, dismissButton: AlertItem.dismessButton)
        }
    }
}

#Preview {
    AccountView()
}
