//
//  NetworkManager.swift
//  OrderApp
//
//  Created by FDCI on 11/9/23.
//

import UIKit
import SwiftUI

final class NetworkManager {
    static let share = NetworkManager()
    private let cache = NSCache<NSString , UIImage>()
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let loginURL = "http://localhost:8080/auth"
    private let UserURL = "http://localhost:8080/users/"
    private let UserUpdateURL = "http://localhost:8080/updateuser/"
    private let appetizerURL = baseURL + "appetizers"
    private let appetizerNewURL = "http://localhost:8080/getmenu"

    private init() {}
    func getAppetizer(completed: @escaping (Result<[Appetizer], APError>) -> Void){
        guard let url = URL(string: appetizerNewURL) else{
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func loginUser(username: String, password: String, completed: @escaping (Result<login, APError>) -> Void) {
        // Construct the login URL and parameters
        guard let url = URL(string: loginURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let credentials = ["username": username, "password": password]
        
        // Create a request with the login URL and set the HTTP method to POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Encode the credentials as JSON and set the request body
            let jsonData = try JSONSerialization.data(withJSONObject: credentials)
            request.httpBody = jsonData
        } catch {
            completed(.failure(.invalidData))
            return
        }
        // Create a URLSession data task to perform the login request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("Response Body: \(body)")
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                // Decode the response data into a User object
                let decoder = JSONDecoder()
                let user = try decoder.decode(login.self, from: data)
                print(user)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        // Resume the data task to initiate the network request
        task.resume()
    }
    
    func fetchUserInfo(userId: Int, completed: @escaping (Result<User1, APError>) -> Void) {
        // Construct the login URL and parameters
        let FetchUserURL =  UserURL + "\(userId)"
        print(FetchUserURL)
        guard let url = URL(string: FetchUserURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(User1.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    func UpdateUser(name: String, email: String, id: Int, completed: @escaping (Result<User1, APError>) -> Void) {
        // Construct the login URL and parameters
        guard let url = URL(string: UserUpdateURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let credentials = ["name": name, "email": email, "id": id] as [String : Any]
        
        // Create a request with the login URL and set the HTTP method to POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Encode the credentials as JSON and set the request body
            let jsonData = try JSONSerialization.data(withJSONObject: credentials)
            request.httpBody = jsonData
        } catch {
            completed(.failure(.invalidData))
            return
        }
        // Create a URLSession data task to perform the login request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("Response Body: \(body)")
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                // Decode the response data into a User object
                let decoder = JSONDecoder()
                let user = try decoder.decode(User1.self, from: data)
                print(user)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        // Resume the data task to initiate the network request
        task.resume()
    }
    
    
    func downloadImage(fromURLString: String, completed:@escaping (UIImage?) -> Void){
        let cacheKey  = NSString(string: fromURLString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        guard let url = URL(string: fromURLString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
            guard let data = data , let image = UIImage(data: data)else{
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
        
    }
    
    
    func pay(from order: Order, completed: @escaping (Result<CheckoutSession, APError>) -> Void) {
        var lineItems: [LineItem] = []
        for appetizer in order.Items {
            let itemAmount = Int(appetizer.Item.price * 100)
            let lineItem = LineItem(
                amount: itemAmount,
                currency: "PHP",
                description: appetizer.Item.description,
                images: [appetizer.Item.imageURL], // Assuming imageURL is a String
                name: appetizer.Item.name,
                quantity: appetizer.count
            )
            
            lineItems.append(lineItem)
        }
        let lineItemsAsDictionaries: [[String: Any]] = lineItems.map { lineItem in
            return [
                "currency": lineItem.currency,
                "images": lineItem.images,
                "amount": Int(lineItem.amount),
                "description": lineItem.description,
                "name": lineItem.name,
                "quantity": lineItem.quantity
            ]
        }
        let headers = [
            "accept": "application/json",
            "Content-Type": "application/json",
            "authorization": "Basic c2tfdGVzdF9FR3FtUlc4ZHdVV0hubWdkY0d0Z1Jja2U6QmFkb2Nza3lAMjI3"
        ]
        var request = URLRequest(url: URL(string: "https://api.paymongo.com/v1/checkout_sessions")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        do {
            let body = ["data": [
                "attributes" : [
                    "send_email_receipt": true,
                    "show_description": true,
                    "show_line_items": true,
                    "line_items": lineItemsAsDictionaries,
                    "description": "Food Pandas",
                    "reference_number": "12345",
                    "payment_method_types": ["gcash", "card", "paymaya"]
                ]
            ]
            ] as [String : Any]
            
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
            // Now you can use jsonData as the HTTP request body
        } catch {
            // Handle the error, e.g., print or log it
            print("Error converting dictionary to JSON data: \(error)")
        }
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            
            
            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("Response Body: \(body)")
            }
            
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completed(.failure(.invalidResponse))
                return
            }
            
            
            
            do {
                let checkoutSessionResponse = try JSONDecoder().decode(CheckoutSession.self, from: data!)
                completed(.success(checkoutSessionResponse))
            } catch {
                completed(.failure(.invalidURL))
            }
            
        }
        
        dataTask.resume()
    }
   
}
