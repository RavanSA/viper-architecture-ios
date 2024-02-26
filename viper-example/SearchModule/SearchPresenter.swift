//
//  SearchPresenter.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewController?
    var router: SearchRouterProtocol?
    var interactor: SearchInteractorProtocol?
    
    func getAllProducts() -> CoreDataObservable<ProductsEntity>? {
        return interactor?.getAllProducts()
    }
    
    func routeToProductDetail(productID id: Int) {
        router?.routeToProductDetail(productID: id)
    }
    
    func onFetchCategoriesSucces(response: [String]) {
        view?.fetchedCategoriesSuccesfully(response: response)
    }
    
    func onFetchCategoriesFailed() {
        view?.fetchedCategoriesFailed()
    }
    
    func fetchCategories() {
        interactor?.didFetchCategories()
    }
    
}
