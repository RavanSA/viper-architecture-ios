//
//  SearchProductsCell.swift
//  viper-example
//
//  Created by Revan SADIGLI on 25.02.2024.
//

import UIKit
import Kingfisher

class SearchProductsCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productReviews: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    
    func setup(item: ProductsEntity) {
        let url = URL(string: item.image ?? "")

        productTitle.text = item.title
        productPrice.text = "\(item.price.toString()) USD"
        productRating.text = "\(item.rateCount) Star"
        productReviews.text = "\(item.rate ?? "") Rating"
        
        productImage.kf.setImage(with: url)
    }
}
