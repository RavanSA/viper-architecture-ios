//
//  MockNetworkManager.swift
//  viper-exampleTests
//
//  Created by Revan SADIGLI on 10.03.2024.
//

import Foundation
@testable import viper_example

class MockNetworkManager: NetworkManagerProtocol {
    var mockData: Data?
    var mockError: Error?

    func fetch<T1: Encodable, T2: Decodable>(_ method: String!, parameter: T1, httpMethod type: String, onSuccess: ((T2) -> Void)? = nil, onFailed: ((String) -> Void)? = nil) {
        if let error = mockError {
            onFailed?("Mocked error: \(error.localizedDescription)")
        } else if let data = mockData {
            do {
                let decoded = try JSONManager().decoder.decode(T2.self, from: data)
                onSuccess?(decoded)
            } catch let error {
                onFailed?("Decoding error: \(error.localizedDescription)")
            }
        } else {
            onFailed?("No mock data or error provided.")
        }
    }
}
