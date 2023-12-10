//
//  ProductDetailRouter.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import UIKit

class ProductDetailRouter : ProductDetailRouterProtocol {
    
    
    weak var view: UIViewController?
    
    static func createModule(vc: ProductDetailViewController) {
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()

        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor

    }
    
    func routeToProducs() {
        
    }
    
}
