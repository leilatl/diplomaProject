//
//  RequestProvider.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 4/26/22.
//

import Foundation
import SwiftKeychainWrapper

class RequestProvider {
    var urlString: String
    var httpMethod: String
    var allHTTPHeaderFields: [String: String]?
    var httpBody: Data?
    
    
    init(urlString: String,
         httpMethod: String,
         allHTTPHeaderFields: [String: String]? = nil,
         httpBody: Data? = nil) {
        self.urlString = urlString
        self.httpMethod = httpMethod
        self.allHTTPHeaderFields = allHTTPHeaderFields
        self.httpBody = httpBody
    }
    
    func createRequest() -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") 
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            request.allHTTPHeaderFields = allHTTPHeaderFields
        }
        return request
    }
}
class SearchRequestProvider {
    var urlString: String
    var httpMethod: String
    var searchString: String
    var allHTTPHeaderFields: [String: String]?
    var httpBody: Data?
    
    
    init(urlString: String,
         httpMethod: String, serchString: String,
         allHTTPHeaderFields: [String: String]? = nil,
         httpBody: Data? = nil) {
        self.urlString = urlString
        self.httpMethod = httpMethod
        self.allHTTPHeaderFields = allHTTPHeaderFields
        self.httpBody = httpBody
        self.searchString = serchString
    }
    
    func createRequest() -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
            //request.addValue(searchString, forHTTPHeaderField: "search")
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            request.allHTTPHeaderFields = allHTTPHeaderFields
        }
        return request
    }
}

class AuthorizedRequestProvider {
    var urlString: String
    var httpMethod: String
    var allHTTPHeaderFields: [String: String]?
    var httpBody: Data?
    
    
    init(urlString: String,
         httpMethod: String,
         allHTTPHeaderFields: [String: String]? = nil,
         httpBody: Data? = nil) {
        self.urlString = urlString
        self.httpMethod = httpMethod
        self.allHTTPHeaderFields = allHTTPHeaderFields
        self.httpBody = httpBody
    }
    
    func createRequest() -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let accessToken: String = KeychainWrapper.standard.string(forKey: "access_token")!
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            request.allHTTPHeaderFields = allHTTPHeaderFields
        }
        return request
    }
}
