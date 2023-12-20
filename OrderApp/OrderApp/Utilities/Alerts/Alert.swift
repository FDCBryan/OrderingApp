//
//  Alert.swift
//  OrderApp
//
//  Created by FDCI on 11/9/23.
//

import SwiftUI

struct AlertItem : Identifiable{
    let id = UUID()
    let title: Text
    let message: Text
    let dismessButton: Alert.Button
}

struct AlertContext {
    static let invalidURL = AlertItem(title: Text("Server Error"), message: Text("invalid URL"), dismessButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Server Error"), message: Text("invalid Response"), dismessButton: .default(Text("OK")))
    static let invalidData = AlertItem(title: Text("Server Error"), message: Text("invalid Data"), dismessButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("unable To Complete: Connection Error"), dismessButton: .default(Text("OK")))
    static let EmptyValue = AlertItem(title: Text("Registration Error"), message: Text("Field is Empty"), dismessButton: .default(Text("OK")))
    static let InvalidEmail = AlertItem(title: Text("Registration Error"), message: Text("Email is Invalid"), dismessButton: .default(Text("OK")))
    static let userSaveSuccess = AlertItem(title: Text("Registration Success"), message: Text("User was saved successfully"), dismessButton: .default(Text("OK")))
    static let userSaveFail = AlertItem(title: Text("Registration Fail"), message: Text("Ther was a problem in your registration"), dismessButton: .default(Text("OK")))
    
}

