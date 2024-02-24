//
//  BasketCell.swift
//  viper-example
//
//  Created by Revan SADIGLI on 18.02.2024.
//

import UIKit

class BasketCell: UITableViewCell {
    
    @IBOutlet weak var productPicture: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var minusBtn: UIImageView!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var plusBtn: UIImageView!
    @IBOutlet weak var deleteBtn: UIImageView!
    
    func setup(item: Basket) {
        let url = URL(string: item.image ?? "")

        let deleteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteBtnTapped(_:)))

        let plusGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(plusBtnTapped(_:)))
        
        let minusGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(minusBtnTapped(_:)))
        
        productTitle.text = item.productTitle
        productDescription.text = item.productDescription
        productCount.text = "\(item.productQuantity)"
        
        productPicture.kf.setImage(with: url)

        deleteBtn.addGestureRecognizer(deleteGestureRecognizer)
        plusBtn.addGestureRecognizer(plusGestureRecognizer)
        minusBtn.addGestureRecognizer(minusGestureRecognizer)

        deleteBtn.userInfo = ["productID": Int(item.productID)]
        plusBtn.userInfo = ["productID": Int(item.productID), "quantity": Int(item.productQuantity)]
        minusBtn.userInfo = ["productID": Int(item.productID), "quantity": Int(item.productQuantity)]

    }
    
    
    @objc func deleteBtnTapped(_ sender: UITapGestureRecognizer) {
        if let userInfo = (sender.view as? UIImageView)?.userInfo as? [String: Any],
           let _ = userInfo["productID"] as? Int {
            NotificationCenter.default.post(name: Notification.Name("DeleteBtnTapped"), object: nil, userInfo: userInfo)
        }
    }
    
    @objc func plusBtnTapped(_ sender: UITapGestureRecognizer) {
        if let userInfo = (sender.view as? UIImageView)?.userInfo as? [String: Any],
           let _ = userInfo["productID"] as? Int,
           let _ = userInfo["quantity"] as? Int {
            NotificationCenter.default.post(name: Notification.Name("PlusBtnTapped"), object: nil, userInfo: userInfo)
        }
    }
    
    @objc func minusBtnTapped(_ sender: UITapGestureRecognizer) {
        if let userInfo = (sender.view as? UIImageView)?.userInfo as? [String: Any],
           let _ = userInfo["productID"] as? Int,
           let _ = userInfo["quantity"] as? Int {
            NotificationCenter.default.post(name: Notification.Name("MinusBtnTapped"), object: nil, userInfo: userInfo)
        }
    }
    
}
