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
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int)
    func fetchProduct(byId id: Int) -> CoreDataObservable<Basket>?
}

protocol ProductDetailPresenterProtocol: AnyObject {
    func onFetchProductDetailSucces(response: ProductDetailResponse)
    func onFetchProductDetailFailed(errorMsg: String)
    func onFetchProductQuantity(byId id: Int) -> CoreDataObservable<Basket>?
    func fetchProductDetail(productID: Int?)
    func onAddToBasket(product: ProductDetailResponse?)
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int)
    func routeToProducts()
}

protocol ProductDetailViewControllerProtocol: AnyObject {
    func fetchedProductDetailSuccesfully(response: ProductDetailResponse)
    func fetchedProductDetailFailed(errorMsg: String)
}

protocol ProductDetailRouterProtocol {
    func routeToProducs()
}
