//
//  ProductsInteractor.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation

class ProductsInteractor : ProductsInteractorProtocol {
    
    var presenter: ProductsPresenterProtocol?

    func didFetchProducts() {
        NetworkManager.shared.fetch("products", parameter: ProductsDTORequest(), httpMethos: "GET", onSuccess: { (response: ProductsDTO) in
            self.presenter?.onFetchProductsSucces(response: response)
        }, onFailed: { errorMsg in
            self.presenter?.onFetchProductsFailed()
        })
    }
    
    
}
