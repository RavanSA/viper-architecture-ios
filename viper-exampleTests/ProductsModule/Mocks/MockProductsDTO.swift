//
//  MockProductsDTO.swift
//  viper-exampleTests
//
//  Created by Revan SADIGLI on 10.03.2024.
//

import Foundation
@testable import viper_example

let mockResponse: [ProductsDTOElement] = [
    ProductsDTOElement(
        id: 1,
        title: "Sample Product 1",
        price: 99.99,
        description: "This is a sample product description.",
        category: Category.electronics.rawValue,
        image: "sample_image_url_1",
        rating: Rating(rate: 4.5, count: 100)
    ),
    ProductsDTOElement(
        id: 2,
        title: "Sample Product 2",
        price: 49.99,
        description: "Another sample product description.",
        category: Category.jewelery.rawValue,
        image: "sample_image_url_2",
        rating: Rating(rate: 3.8, count: 50)
    )
]
