//
//  NetworkService.swift
//  AskhanaFinal
//
//  Created by Leila Tolegenova on 4/26/22.
//

import Foundation
 
class NetworkingService {
    func fetch<T: Decodable>(requestProvider: RequestProvider, completion: ((T)->())?) {
        guard let request = requestProvider.createRequest() else {
            return
        }
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let decoder = JSONDecoder()
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            guard let _ = response else {
                return
            }
            
            do {
                let value = try decoder.decode(T.self, from: data)
                completion?(value)
            } catch {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                   print(JSONString)
                }
                print(error)
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
class SearchNetworkingService {
    func fetch<T: Decodable>(requestProvider: SearchRequestProvider, completion: ((T)->())?) {
        guard let request = requestProvider.createRequest() else {
            return
        }
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let decoder = JSONDecoder()
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            guard let _ = response else {
                return
            }
            
            do {
                let value = try decoder.decode(T.self, from: data)
                completion?(value)
            } catch {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                   print(JSONString)
                }
                print(error)
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
class AuthorizedNetworkingService {
    func fetch<T: Decodable>(requestProvider: AuthorizedRequestProvider, completion: ((T)->())?) {
        guard let request = requestProvider.createRequest() else {
            return
        }
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let decoder = JSONDecoder()
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            guard let _ = response else {
                return
            }
            
            do {
                let value = try decoder.decode(T.self, from: data)
                completion?(value)
            } catch {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                   //print(JSONString)
                }
                print(error)
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}
