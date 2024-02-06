//
//  ProductDetailEntity.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import Foundation

// MARK: - DTO
struct ProductDetailDTORequest : Encodable {
    
}

struct ProductDetailResponse: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: ProductDetailRating
}

struct ProductDetailRating: Codable {
    let rate: Double
    let count: Int
}

// MARK: Enum
enum BasketActionType {
    case increaseProductQuantity
    case descreaseProductQuantity
}
