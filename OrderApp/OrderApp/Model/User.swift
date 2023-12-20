//
//  User.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import Foundation

struct User : Codable{
    var firstname = ""
    var lastName = ""
    var email = ""
    var phone = ""
    var username = ""
    var password = ""
    var Isadmin = false
    var birthday = Date()
}

struct User1 : Codable{
    var id: Int = 0
    var email: String = ""
    var username  : String = ""
    var password : String = ""
    var name : String = ""
}

struct login : Codable{
    var success: Bool
    var user: User1?
    var message: String?
}


final class UserInfo: ObservableObject{
    @Published var userInfo : User1?
}
