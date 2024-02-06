//
//  ProductDetailProtocol.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    func didFetchProductDetail(productID: Int?)
    func insertProductToBasket(product: ProductDetailResponse?)
    func updateProductQuantity(actionType:  BasketActionType, product: ProductDetailResponse?)
}

protocol ProductDetailPresenterProtocol: AnyObject {
    func onFetchProductDetailSucces(response: ProductDetailResponse)
    func onFetchProductDetailFailed(errorMsg: String)
    func fetchProductDetail(productID: Int?)
    func onAddToBasket(product: ProductDetailResponse?)
    func onProductQuantityIncrease(productID: Int)
    func onProductQuantityDecrease(productID: Int)
    func routeToProducts()
}

protocol ProductDetailViewControllerProtocol: AnyObject {
    func fetchedProductDetailSuccesfully(response: ProductDetailResponse)
    func fetchedProductDetailFailed(errorMsg: String)
}

protocol ProductDetailRouterProtocol {
    func routeToProducs()
}
