//
//  ProductDetailProtocol.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    func didFetchProductDetail(productID: Int?)
}

protocol ProductDetailPresenterProtocol: AnyObject {
    func onFetchProductDetailSucces(response: ProductDetailResponse)
    func onFetchProductDetailFailed(errorMsg: String)
    func fetchProductDetail(productID: Int?)
    func routeToProducts()
}

protocol ProductDetailViewControllerProtocol: AnyObject {
    func fetchedProductDetailSuccesfully(response: ProductDetailResponse)
    func fetchedProductDetailFailed(errorMsg: String)
}

protocol ProductDetailRouterProtocol {
    func routeToProducs()
}
