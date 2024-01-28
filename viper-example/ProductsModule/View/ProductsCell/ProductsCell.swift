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
//        addShadow()
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
        productDescription.text = "\(products.price) USD"
        addRoundedView("\(products.rating.rate)")
    }

    
    func addRoundedView(_ rating: String) {
        let roundedView = UIView()
        roundedView.backgroundColor = UIColor.white
        
        roundedView.frame = CGRect(x: 0, y: 20, width: 45, height: 20)

        roundedView.backgroundColor = UIColor.white
        let cornerRadii = CGSize(width: 20, height: 20)
        let maskPath = UIBezierPath(roundedRect: roundedView.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        roundedView.layer.mask = maskLayer
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 0
        
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        labelStackView.spacing = 0
        
        let titleLabel = UILabel()
        titleLabel.text = rating
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        labelStackView.addArrangedSubview(titleLabel)
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        
        mainStackView.addArrangedSubview(labelStackView)
        mainStackView.addArrangedSubview(imageView)
        
        roundedView.addSubview(mainStackView)
        
        contentView.addSubview(roundedView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: 0)
        ])
    }

    private func addShadow() {
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }



}
