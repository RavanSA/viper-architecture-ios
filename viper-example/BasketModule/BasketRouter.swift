//
//  BasketRouter.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import Foundation
import UIKit

class BasketRouter : BasketRouterProtocol {
    
    
    weak var view: UIViewController?
    
    static func createModule(vc: BasketViewController) {
        let interactor = BasketInteractor()
        let presenter = BasketPresenter()
        let router = BasketRouter()

        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
    }
    
}
