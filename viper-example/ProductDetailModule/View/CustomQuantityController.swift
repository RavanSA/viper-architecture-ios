//
//  CustomQuantityController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 3.02.2024.
//

import UIKit

class CustomQuantityController: UIView {
    
    var onPlusButtonClicked: (() -> ())?
    var onMinusButtonClicked: (() -> ())?
    
    lazy var btnMinus: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "minus.square")?.withRenderingMode(.alwaysTemplate).resized(toWidth: 30, toHeight: 30), for: .normal)
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var tvProductQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var btnPlus: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setBackgroundImage(UIImage(named: "red_button_background"), for: .normal)
        button.setImage(UIImage(systemName: "plus.app")?.withRenderingMode(.alwaysTemplate).resized(toWidth: 30, toHeight: 30), for: .normal)
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(btnMinus)
        addSubview(tvProductQuantity)
        addSubview(btnPlus)
        assignClosures()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            btnMinus.leadingAnchor.constraint(equalTo: leadingAnchor),
            btnMinus.topAnchor.constraint(equalTo: topAnchor),
            btnMinus.heightAnchor.constraint(equalToConstant: 30),
            btnMinus.widthAnchor.constraint(equalToConstant: 30),
            
            tvProductQuantity.leadingAnchor.constraint(equalTo: btnMinus.trailingAnchor, constant: 32),
            tvProductQuantity.centerYAnchor.constraint(equalTo: btnMinus.centerYAnchor),
            
            btnPlus.leadingAnchor.constraint(equalTo: tvProductQuantity.trailingAnchor, constant: 32),
            btnPlus.centerYAnchor.constraint(equalTo: btnMinus.centerYAnchor),
            btnPlus.heightAnchor.constraint(equalToConstant: 30),
            btnPlus.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func setQuantity(_ quantity: String) {
        tvProductQuantity.text = quantity
    }
    
    func showQuantityControls(_ show: Bool) {
        btnMinus.isHidden = !show
        tvProductQuantity.isHidden = !show
        btnPlus.isHidden = !show
    }
    
    private func assignClosures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        tvProductQuantity.addGestureRecognizer(tapGesture)
        
        btnMinus.addTarget(self, action: #selector(onMinusBtnClicked), for: .touchUpInside)
    }
    
    @objc func onPlusBtnClicked() {
        onPlusButtonClicked?()
    }
    
    @objc func onMinusBtnClicked() {
        onMinusButtonClicked?()

    }
    
    @objc func labelTapped() {

    }

    
}
