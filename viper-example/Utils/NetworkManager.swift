//
//  NetworkManager.swift
//  viper-example
//
//  Created by Revan Sadigli on 12.11.2023.
//

import Foundation

final public class NetworkManager: NSObject {
    
    public static let shared: NetworkManager = NetworkManager()
    
    public func fetch<T1: Encodable, T2: Decodable>(_ method: String!, parameter: T1, httpMethos type: String, onSuccess: ((T2) -> Void)? = nil, onFailed: ((String) -> Void)? = nil) {
        
        let webService = EndPoints.BASE_URL
        
        guard let url = URL(string: "\(webService)\(method!)") else {return}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = type
        
        URLSession.shared.dataTask(with: urlRequest) { data, response , error in
            
            if let error = error {
                onFailed?("\(error)")
            }
            
            guard let data = data else {return}
            
            do {
                let decoded = try JSONManager().decoder.decode(T2.self, from: data)
                onSuccess?(decoded)
            } catch let error {
                onFailed?("\(error)")
                return
            }
            
        }.resume()
    }
}
