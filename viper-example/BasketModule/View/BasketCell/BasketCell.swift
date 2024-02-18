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
        productTitle.text = item.productTitle
        productDescription.text = item.productDescription
        productCount.text = "1"
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: item.image ?? "")
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.productPicture.image = UIImage(data: data)
                }
            }
        }

        let deleteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteBtnTapped(_:)))

        let plusGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(plusBtnTapped(_:)))
        
        let minusGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(minusBtnTapped(_:)))

        deleteBtn.addGestureRecognizer(deleteGestureRecognizer)
        plusBtn.addGestureRecognizer(plusGestureRecognizer)
        minusBtn.addGestureRecognizer(minusGestureRecognizer)

    }
    
    
    @objc func deleteBtnTapped(_ sender: UITapGestureRecognizer) {
        print("deleteBtnTapped tapped in cell")
        NotificationCenter.default.post(name: Notification.Name("DeleteBtnTapped"), object: nil)
    }
    
    @objc func plusBtnTapped(_ sender: UITapGestureRecognizer) {
        print("plusBtnTapped tapped in cell")
        NotificationCenter.default.post(name: Notification.Name("PlusBtnTapped"), object: nil)
    }
    
    @objc func minusBtnTapped(_ sender: UITapGestureRecognizer) {
        print("minusBtnTapped tapped in cell")
        NotificationCenter.default.post(name: Notification.Name("MinusBtnTapped"), object: nil)
    }
    
}
