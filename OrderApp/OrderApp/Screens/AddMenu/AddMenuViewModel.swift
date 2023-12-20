//
//  AddMenuViewModel.swift
//  OrderApp
//
//  Created by FDCI on 11/24/23.
//

import SwiftUI

class AddMenuViewModel :ObservableObject{
    @Published var id: Int?
    @Published var imageString: String?
    @Published var selectedImage: UIImage?
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var price: Double = 0
    @Published var calories: Int = 0
    @Published var protein: Int = 0
    @Published var carbs: Int = 0
    
    
    
    
    func reset() {
        
        DispatchQueue.main.async {
            // Set selectedImage to nil
            self.selectedImage = nil
            self.imageString = nil
            self.name = ""
            self.description = ""
            self.price = 0
            self.calories = 0
            self.protein = 0
            self.carbs = 0
        }
    }
    
    
    func getData(for appetizer: Appetizer) {
        guard let imageURL = URL(string: appetizer.imageURL) else {
            return // Handle invalid URL
        }

        // Use URLSession to fetch the image data
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Update the UI on the main thread
                    self.id = appetizer.id
                    self.selectedImage = image
                    self.imageString = appetizer.imageURL
                    self.name = appetizer.name
                    self.description = appetizer.description
                    self.price = appetizer.price
                    self.calories = appetizer.calories
                    self.protein = appetizer.protein
                    self.carbs = appetizer.carbs
                }
            } else {
                // Handle error
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }

    
    
    
    func uploadImageToServer(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        // Set your server upload endpoint URL
        guard let url = URL(string: "http://localhost:8080/uploadImage") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Create a URLRequest with the specified URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create a boundary string for multipart/form-data
        let boundary = "Boundary-\(UUID().uuidString)"
        
        // Set the request's content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the HTTP body for the image upload
        var body = Data()
        body.append(contentsOf: "--\(boundary)\r\n".data(using: .utf8)!)
        body.append(contentsOf: "Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append(contentsOf: "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append(contentsOf:"\r\n".data(using: .utf8)!)
        body.append(contentsOf:"--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Attach the body to the request
        request.httpBody = body
        
        // Create a data task to perform the upload
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let jsonDict = jsonObject as? [String: Any],
               let success = jsonDict["success"] as? Bool,
               let imageUrl = jsonDict["imageUrl"] as? String {
                
                if success {
                    completion(.success(imageUrl))
                } else {
                    // Handle the case where the server response indicates failure
                    completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
                }
            }else {
                completion(.failure(NSError(domain: "Invalid server response", code: 0, userInfo: nil)))
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    
    func saveDataToServer() {
        
        // Replace with your server endpoint URL
        let serverURL = URL(string: "http://localhost:8080/addmenu")!
        
        // Create a URLRequest
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a dictionary with your data
        let dataToSend: [String: Any] = [
            "id": name,
            "name": name,
            "description": description,
            "price": price,
            "calories": calories,
            "protein": protein,
            "carbs": carbs,
            "imageURL": imageString
        ]
        
        // Convert the dictionary to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataToSend)
            request.httpBody = jsonData
        } catch {
            print("Error converting data to JSON: \(error)")
            return
        }
        
        // Create a URLSession data task to send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending data to server: \(error)")
                return
            }
            
            // Handle the response from the server if needed
            if let httpResponse = response as? HTTPURLResponse {
                print("Server response code: \(httpResponse.statusCode)")
                self.reset()
            }
        }.resume()
    }
  
    
    
    func updateDataToServer(completion: @escaping (Result<Void, Error>) -> Void) {
        // Replace with your server endpoint URL
        let serverURL = URL(string: "http://localhost:8080/updatemenu")!
        
        // Create a URLRequest
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a dictionary with your data
        let dataToSend: [String: Any] = [
            "id": id!,
            "name": name,
            "description": description,
            "price": price,
            "calories": calories,
            "protein": protein,
            "carbs": carbs,
            "imageURL": imageString
        ]
        
        // Convert the dictionary to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataToSend)
            request.httpBody = jsonData
        } catch {
            print("Error converting data to JSON: \(error)")
            completion(.failure(error))
            return
        }
        
        // Create a URLSession data task to send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending data to server: \(error)")
                completion(.failure(error))
                return
            }
            
            // Handle the response from the server if needed
            if let httpResponse = response as? HTTPURLResponse {
                print("Server response code: \(httpResponse.statusCode)")
                
                // Check the response status code and handle it accordingly
                if 200 ..< 300 ~= httpResponse.statusCode {
                    // Successful response
                    self.reset()
                    completion(.success(()))
                }
            }
        }.resume()
    }


}
