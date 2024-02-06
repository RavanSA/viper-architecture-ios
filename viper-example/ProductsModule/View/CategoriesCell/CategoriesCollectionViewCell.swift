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
        categoryImage.image = UIImage(systemName: category.categoryImage)
        categoryImage.layer.cornerRadius = 10
        categoryImage.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}
