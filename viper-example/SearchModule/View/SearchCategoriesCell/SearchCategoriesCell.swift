//
//  CategoriesCell.swift
//  viper-example
//
//  Created by Revan SADIGLI on 25.02.2024.
//

import UIKit

class SearchCategoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    
    override var isSelected: Bool {
        didSet {
            updateBorderColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.cornerRadius = 5
        updateBorderColor()
    }
    
    func setup(item: CategoriesItem) {
        categoryName.text = item.categoryName
    }
    
    private func updateBorderColor() {
        if isSelected {
            layer.borderColor = UIColor.blue.cgColor
        } else {
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
}
