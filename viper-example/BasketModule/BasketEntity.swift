//
//  BasketEntity.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import Foundation

struct BasketModel {
    var category: String
    var productDescription: String
    var basketID: Int
    var productID: Int
    var image: String
    var price: String
    var ratingCount: String
    var ratingRate: String
    var title: String
    var productQuantity: Int
    var userID: Int
}

let mockBasketData: [BasketModel] = [
    BasketModel(category: "Electronics", productDescription: "Smartphone with advanced features", basketID: 1, productID: 101, image: "phone_image", price: "$999", ratingCount: "50", ratingRate: "4.5", title: "Smartphone XYZ", productQuantity: 1, userID: 1001),
    BasketModel(category: "Clothing", productDescription: "Casual t-shirt for everyday wear", basketID: 2, productID: 102, image: "tshirt_image", price: "$29.99", ratingCount: "30", ratingRate: "4.2", title: "Casual T-shirt", productQuantity: 2, userID: 1002),
    BasketModel(category: "Books", productDescription: "Bestselling novel by famous author", basketID: 3, productID: 103, image: "book_image", price: "$15.50", ratingCount: "45", ratingRate: "4.7", title: "Bestseller Novel", productQuantity: 1, userID: 1003),
    // Add more mock data as needed
]
