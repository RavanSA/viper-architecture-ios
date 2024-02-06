//
//  ProductDetailViewController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import UIKit

class ProductDetailViewController: UIViewController, ProductDetailViewControllerProtocol {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRatingPoint: UILabel!
    @IBOutlet weak var productRatingCount: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var buyNowBtn: UIButton!

    var presenter: ProductDetailPresenterProtocol?
    var productID: Int?
    var productDetail: ProductDetailResponse?

    private lazy var productQuantityView = CustomQuantityController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductDetailRouter.createModule(vc: self)

        setupNavigationBar()
        presenter?.fetchProductDetail(productID: productID)
    }

    func fetchedProductDetailSuccesfully(response: ProductDetailResponse) {
        self.productDetail = response
        setupUI()
    }

    func fetchedProductDetailFailed(errorMsg: String) {
        showMessage("Error!", title: errorMsg)
    }

}

extension ProductDetailViewController {

    private func setupUI() {

        DispatchQueue.main.async {
            self.setupConstraints()

            self.productTitle.text = self.productDetail?.title
            self.productPrice.text = self.productDetail?.price.toString()
            self.productRatingCount.text = self.productDetail?.rating.rate.toString()
            self.productRatingPoint.text = self.productDetail?.rating.count.toString()
            self.productDescription.text = self.productDetail?.description
            
            self.buyNowBtn.setTitle("Buy now", for: .normal)
            self.buyNowBtn.setTitleColor(UIColor.white, for: .normal)
            self.buyNowBtn.backgroundColor = UIColor.black
            self.buyNowBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            self.buyNowBtn.addTarget(self, action: #selector(self.onBuyNowBtnClicked), for: .touchUpInside)
            self.buyNowBtn.layer.cornerRadius = 20
        }

        DispatchQueue.global(qos: .background).async {
            let url = URL(string: self.productDetail?.image ?? "")!
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func setupNavigationBar() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(onRightButtonTapped))
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(onRightButtonTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(onBackButtonClicked))

        let rightButtons = [shareButton, saveButton]
        self.navigationItem.rightBarButtonItems = rightButtons

        let leftButton = [backButton]
        self.navigationItem.leftBarButtonItems = leftButton
    }

    @objc func onRightButtonTapped() {
        
    }
    
    @objc func onBackButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onBuyNowBtnClicked() {
        presenter?.onAddToBasket(product: productDetail)
        self.buyNowBtn.isHidden = true
        toggleControlsVisibility()
    }
    
    private func setupConstraints() {
        self.view.addSubview(productQuantityView)
        
        productQuantityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productQuantityView.topAnchor.constraint(equalTo: productDescription.bottomAnchor),
            productQuantityView.leadingAnchor.constraint(equalTo: productDescription.leadingAnchor),
            productQuantityView.trailingAnchor.constraint(equalTo: productDescription.trailingAnchor)
        ])
        
        productQuantityView.setQuantity("1")
        
        productQuantityView.showQuantityControls(false)
        productQuantityView.isUserInteractionEnabled = true
        
        productQuantityView.btnPlus.addTarget(self, action: #selector(onPlusButtonClicked), for: .touchUpInside)
        productQuantityView.btnMinus.addTarget(self, action: #selector(onMinusButtonClicked), for: .touchUpInside)
        
        productQuantityView.onPlusButtonClicked = {
            
        }
        
        productQuantityView.onMinusButtonClicked = {
            
        }
    }
    
     func toggleControlsVisibility() {
         productQuantityView.showQuantityControls(true)
     }
     
     func updateQuantity() {

     }
    
    @objc func onPlusButtonClicked() {

    }
    
    @objc func onMinusButtonClicked() {

    }

}
