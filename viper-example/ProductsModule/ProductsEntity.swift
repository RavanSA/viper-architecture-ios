//
//  ProductsEntity.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation

struct Categories {
    let categoryName: String
    let categoryImage: String
}

let categories: [Categories] = [
    Categories(categoryName: "PC", categoryImage: "cat1"),
    Categories(categoryName: "Phone", categoryImage: "cat2"),
    Categories(categoryName: "Earphone", categoryImage: "cat3"),
    Categories(categoryName: "Gaming", categoryImage: "cat4"),
    Categories(categoryName: "All", categoryImage: "cat5")
]

struct ProductsDTORequest : Encodable {
    
}


// MARK: - ProductsDTOElement
struct ProductsDTOElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias ProductsDTO = [ProductsDTOElement]
