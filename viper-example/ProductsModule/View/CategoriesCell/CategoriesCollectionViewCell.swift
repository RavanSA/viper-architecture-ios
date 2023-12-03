//
//  CategoriesCollectionViewCell.swift
//  viper-example
//
//  Created by Revan Sadigli on 29.10.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setup(category: Categories) {
        categoryName.text = category.categoryName
        categoryImage.image = UIImage(named: category.categoryImage)
    }
    
    override func layoutSubviews() {
        categoryImage.round()
    }

}
