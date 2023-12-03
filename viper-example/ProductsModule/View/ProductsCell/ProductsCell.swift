//
//  ProductsCell.swift
//  viper-example
//
//  Created by Revan Sadigli on 22.11.2023.
//

import Foundation
import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setup(products: ProductsDTOElement) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: products.image)!
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(data: data)
                }
            }
        }
        
        productName.text = products.title
        productDescription.text = products.description
    }

}
