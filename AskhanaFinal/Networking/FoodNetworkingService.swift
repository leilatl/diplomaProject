//
//  FoodNetworkingService.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 25.04.2022.
//

import Foundation
import SwiftKeychainWrapper
struct Meal: Codable {
    
    var name: String
    var slug: String
    var price: Int
    var protein: Int
    var fats: Int
    var carbs: Int
    var description: String
    var available_inventory: Int
    var category_id: Int
    var id: Int
}
struct FoodCategory: Codable {
    var id: Int
    var name: String
    var get_absolute_url: String
    var meals: [Meal]
}
struct User: Codable {
    var username: String
    var first_name: String
    var last_name: String
    var email: String
    var phone: String
    var balance: Int
    var id: Int
    var created_at: String
    var is_staff: Bool
}
struct UserCreation: Codable{
    var username: String
    var first_name: String
    var last_name: String
    var email: String
    var phone: String
    var balance: Int
    var password: String
    var is_staff: Bool
}
struct LogInCredentials: Codable{
    var email: String
    var password: String
}

struct ShowCart: Codable{
    var id: Int
    var cart_items: [ShowCartItems]
}
struct ShowCartItems: Codable{
    var id: Int
    var meals: Meal
    var quantity: Int
    var created_at: String
    var product_id: Int
}
struct ShowOrder: Codable{
    var id: Int
    var order_date: String
    var order_amount: Int
    var order_status: String
    var order_details: [ShowOrderDetails]
}
struct ShowOrderDetails: Codable{
    var id: Int
    var order_id: Int
    var quantity: Int
    var product_order_details: Meal
    
}
class FoodNetworkingService{
    let networkingService = NetworkingService()
    let authorizedService = AuthorizedNetworkingService()
    let searchService = SearchNetworkingService()
    
    func getMeals(category: String, completion: (([Meal])->())? ) {
        
        
        let url = "https://ashana-app-dproj.herokuapp.com/meals/category/" + category
        let requestProvider = RequestProvider(urlString: url,
                                              httpMethod: "GET")
        
        networkingService.fetch(requestProvider: requestProvider, completion: completion)
    }
    func searchMeals(query: String, completion: (([Meal])->())? ) {
//        var encoded = ""
//        if let data = query.data(using: .windowsCP1251) {
//            encoded = data.map { String(format: "%%%02hhX", $0) }.joined()
//            print(encoded)
//        }
        let encodedTexts = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)

        //let newStr = query.data(using: .utf8)
        let url = "https://ashana-app-dproj.herokuapp.com/meals?search="+encodedTexts!
        
        
        print(url)
        let requestProvider = RequestProvider(urlString: url,
                                              httpMethod: "GET")
        
        networkingService.fetch(requestProvider: requestProvider, completion: completion)
    }
    func getOrders(completion: (([ShowOrder])->())?){
        
        let url = "https://ashana-app-dproj.herokuapp.com/orders/"
        
        let requestProvider = AuthorizedRequestProvider(urlString: url,
                                              httpMethod: "GET")
        authorizedService.fetch(requestProvider: requestProvider, completion: completion)
    }
    
    func getCartItems(completion: ((ShowCart)->())?){
        let url = "https://ashana-app-dproj.herokuapp.com/cart/"
        
        let requestProvider = AuthorizedRequestProvider(urlString: url,
                                              httpMethod: "GET")
        authorizedService.fetch(requestProvider: requestProvider, completion: completion)
        
    
    }
    func getProfile(completion: ((User)->())?){
        let url = "https://ashana-app-dproj.herokuapp.com/users/"
        
        let requestProvider = AuthorizedRequestProvider(urlString: url,
                                              httpMethod: "GET")
        authorizedService.fetch(requestProvider: requestProvider, completion: completion)
        
    
    }
    func deleteCartItem(id: Int){
        let url = URL(string:"https://ashana-app-dproj.herokuapp.com/cart/" + String(id))
        let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token")!
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response: \n \(dataString)")
                
            }
        }
        task.resume()
        
    }
    
    func createUser(user: UserCreation) {
        let url = URL(string: "https://ashana-app-dproj.herokuapp.com/users/")
        guard let requestURL = url else {fatalError()}
        var request = URLRequest(url: requestURL)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let newUser = user
        
        let jsonData = try! JSONEncoder().encode(newUser)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response: \n \(dataString)")
            }
                
            
        }
        task.resume()
        
    }
    func postOrder(){
        let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token")!
        let url = URL(string: "https://ashana-app-dproj.herokuapp.com/orders/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response: \n \(dataString)")
                
            }
        }
        task.resume()
    }
    
    func addItemToCart(itemID: Int, quantity: Int){
        let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token")!
        let url = URL(string: "https://ashana-app-dproj.herokuapp.com/cart/\(itemID)?quantity=\(quantity)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        

        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        //request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo2LCJleHAiOjE2NTQwMjUyMzN9.ccE_DrlYGWhK4mB5zl8m-4AGoV1Qe0Vvn8a45ncEQH8", forHTTPHeaderField: "Authorization")
        print(accessToken)
        
        
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response: \n \(dataString)")
                
            }
        }
        task.resume()
    }
    
    
    
    
}
