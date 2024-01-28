//
//  ProductsInteractor.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation

class ProductsInteractor : ProductsInteractorProtocol {
    
    var presenter: ProductsPresenterProtocol?
    let viewContext = PersistenceController.shared.viewContext
    let persistentContainer = PersistenceController.shared
    
    func didFetchProducts() {
        NetworkManager.shared.fetch("products", parameter: ProductsDTORequest(), httpMethos: "GET", onSuccess: { (response: ProductsDTO) in
            self.persistentContainer.deleteAll(data: ProductsEntity.self)
            self.addProductsToCache(response: response)
            self.presenter?.onFetchProductsSucces(response: response)
        }, onFailed: { errorMsg in
            self.presenter?.onFetchProductsFailed()
        })
    }
    
    private func addProductsToCache(response: ProductsDTO) {
        response.forEach { product in
            
            do {
                let productEntity = ProductsEntity(context: viewContext)
                
                productEntity.id = Int64(product.id)
                productEntity.category = product.category
                productEntity.image = product.image
                productEntity.productDescription = product.description
                productEntity.price = product.price
                productEntity.rate = product.rating.rate.toString()
                productEntity.rateCount = Int64(product.rating.count)
                
                try viewContext.save()
            } catch {
                print("Error Occured", error)
            }
        }
    }
    
}
