//
//  ProductsInteractor.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation
import CoreData

class ProductsInteractor : ProductsInteractorProtocol {
    
    var presenter: ProductsPresenterProtocol?
    var viewContext: NSManagedObjectContext
    let persistentContainer: PersistenceController
    let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
        viewContext: NSManagedObjectContext = PersistenceController.shared.viewContext,
         persistentContainer: PersistenceController = PersistenceController.shared) {
        self.viewContext = viewContext
        self.persistentContainer = persistentContainer
        self.networkManager = networkManager
    }

    
    func didFetchProducts(request: ProductsDTORequest) {
        networkManager.fetch("products", parameter: request, httpMethod: "GET", onSuccess: { (response: ProductsDTO) in
            self.persistentContainer.deleteAll(data: ProductsEntity.self)
            self.addProductsToCache(response: response)
            self.presenter?.onFetchProductsSucces(response: response)
        }, onFailed: { errorMsg in
            self.presenter?.onFetchProductsFailed()
        })
    }
    
    func addProductsToCache(response: ProductsDTO) {
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
                productEntity.title = product.title
                
                try viewContext.save()
            } catch {
                print("Error Occured", error)
            }
        }
    }
    
    func setViewContext(_ context: NSManagedObjectContext) {
        viewContext = context
    }
    
}
