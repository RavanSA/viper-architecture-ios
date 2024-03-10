//
//  ProductsPresenter.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation

class ProductsPresenter : ProductsPresenterProtocol {
    
    weak var view: ProductsViewControllerProtocol?
    var router: ProductsRouterProtocol?
    var interactor: ProductsInteractorProtocol?
    
    func onFetchProductsSucces(response: ProductsDTO) -> Bool{
        view?.fetchedProductsSuccesfully(response: response)
        return true
    }
    
    func onFetchProductsFailed() -> Bool {
        view?.fetchedProductsFailed()
        return true
    }
    
    func routeToProductDetail() {
        router?.routeToProductDetail()
    }
    
    func routeToBasket() {
        router?.routeToBasket()
    }
    
    func fetchProducts() {
        interactor?.didFetchProducts(request: ProductsDTORequest())
    }
    
}
