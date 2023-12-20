//
//  LoginView.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $viewModel.user.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $viewModel.user.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Login") {
                    viewModel.attemptLogin()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .navigationTitle("Login")
            .fullScreenCover(isPresented: $viewModel.isLoginSuccessful) {
                AppetizerTabView()
            }
        }.alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismessButton
            )
        }
    }
}



#Preview {
    LoginView()
}
