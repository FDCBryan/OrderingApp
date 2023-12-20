//
//  Model.swift
//  OrderApp
//
//  Created by FDCI on 11/6/23.
//

import Foundation

struct Appetizer:Decodable, Identifiable{
    var id:Int
    var name : String
    var description: String
    var price : Double
    var imageURL: String
    var calories: Int
    var protein: Int
    var carbs: Int
}

struct AppetizerResponse: Decodable{
    let request:[Appetizer]
}

struct Mockata{
    static let sampleAppetizer = Appetizer(id: 1, name: "TestnData", description: "Test Data desc", price: 9.90, imageURL: "", calories: 99, protein: 99, carbs: 99)
    static let appetizers = [sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer]
    
    static let Order1 = Appetizer(id: 1, name: "TestnData1", description: "Test Data desc", price: 9.90, imageURL: "", calories: 99, protein: 99, carbs: 99)
    
    static let Order2 = Appetizer(id: 2, name: "TestnData2", description: "Test Data desc", price: 9.90, imageURL: "", calories: 99, protein: 99, carbs: 99)
    
    static let Order3 = Appetizer(id: 3, name: "TestnData3", description: "Test Data desc", price: 9.90, imageURL: "", calories: 99, protein: 99, carbs: 99)
    static let OrderList = [Order1,Order2,Order3]
}
