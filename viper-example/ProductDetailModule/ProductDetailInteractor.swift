//
//  ProductDetailInteractor.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import Foundation

class ProductDetailInteractor : ProductDetailInteractorProtocol {

    var presenter: ProductDetailPresenterProtocol?

    func didFetchProductDetail(productID id : Int?) {
        NetworkManager.shared.fetch("products/\(id ?? 0)", parameter: ProductDetailDTORequest(), httpMethos: "GET", onSuccess: { (response: ProductDetailResponse) in
            self.presenter?.onFetchProductDetailSucces(response: response)
        }, onFailed: { errorMsg in
            self.presenter?.onFetchProductDetailFailed(errorMsg: errorMsg)
        })
    }
    
}
