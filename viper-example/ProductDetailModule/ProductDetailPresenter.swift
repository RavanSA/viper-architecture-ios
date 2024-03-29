//
//  ProductDetailPresenter.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import Foundation

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    weak var view: ProductDetailViewControllerProtocol?
    var router: ProductDetailRouterProtocol?
    var interactor: ProductDetailInteractorProtocol?
    
    func onFetchProductDetailSucces(response: ProductDetailResponse) {
        view?.fetchedProductDetailSuccesfully(response: response)
    }
    
    func onFetchProductDetailFailed(errorMsg: String) {
        view?.fetchedProductDetailFailed(errorMsg: errorMsg)
    }
    
    func routeToProducts() {
        
    }
    
    func fetchProductDetail(productID id: Int?) {
        interactor?.didFetchProductDetail(productID: id)
    }
    
    func onAddToBasket(product: ProductDetailResponse?) {
        interactor?.insertProductToBasket(product: product)
    }
    
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int) {
        interactor?.updateProductQuantity(actionType: actionType, productID: productID, quantity: quantity)
    }
    
    func onFetchProductQuantity(byId id: Int) -> CoreDataObservable<Basket>? {
        return interactor?.fetchProduct(byId: id)
    }
    
}
