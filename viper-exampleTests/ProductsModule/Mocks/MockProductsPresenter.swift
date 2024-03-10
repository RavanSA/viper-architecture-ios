//
//  MockProductsPresenter.swift
//  viper-exampleTests
//
//  Created by Revan SADIGLI on 10.03.2024.
//

import Foundation
@testable import viper_example

class MockProductsPresenter: ProductsPresenterProtocol {
    var fetchedProductsSuccessfullyCalled = false
    var fetchedProductsFailedCalled = false
    var routeToProductDetailCalled = false
    var routeToBasketCalled = false
    var fetchProductsCalled = false

    func onFetchProductsSucces(response: ProductsDTO) -> Bool {
        fetchedProductsSuccessfullyCalled = true
        return fetchedProductsSuccessfullyCalled
    }

    func onFetchProductsFailed() -> Bool {
        fetchedProductsFailedCalled = true
        return fetchedProductsFailedCalled
    }

    func routeToProductDetail() {
        routeToProductDetailCalled = true
    }

    func routeToBasket() {
        routeToBasketCalled = true
    }

    func fetchProducts() {
        fetchProductsCalled = true
    }
}
