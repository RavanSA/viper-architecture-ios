//
//  BasketViewController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import UIKit
import RxSwift
import RxCocoa

class BasketViewController: UIViewController, BasketViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemAmount: UILabel!
    @IBOutlet weak var buyNowBtn: UIButton!
    
    var presenter: BasketPresenterProtocol?
    
    private var disposeBag = DisposeBag()
    private var basketItems: [Basket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BasketRouter.createModule(vc: self)
        
        setupUI()
        addSubscribers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension BasketViewController {
   
    private func setupUI() {
        title = "Basket"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let basketCellNib = UINib(nibName: "BasketCell", bundle: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(basketCellNib, forCellReuseIdentifier: "basketCell")
        
        self.buyNowBtn.setTitle("Buy Now", for: .normal)
        self.buyNowBtn.setTitleColor(UIColor.white, for: .normal)
        self.buyNowBtn.backgroundColor = UIColor.black
        self.buyNowBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.buyNowBtn.addTarget(self, action: #selector(self.onBuyNowBtnClicked), for: .touchUpInside)
    }
    
    private func addSubscribers() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBtnTappedNotification(_:)), name: Notification.Name("DeleteBtnTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(plusBtnTappedNotification(_:)), name: Notification.Name("PlusBtnTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(minusBtnTappedNotification(_:)), name: Notification.Name("MinusBtnTapped"), object: nil)
        
        presenter?.onAllProductsFromBasket()?
            .subscribe(onNext: { [weak self] basket in
                guard let self = self else { return }
                self.itemCount.text = "Total \(basket.count) items"
                self.itemAmount.text = "\(computeTotalAmount(basket: basket)) USD"
                self.basketItems = basket
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func computeTotalAmount(basket: [Basket]) -> Double {
        var totalAmount = 0.0
        basket.forEach { item in
            totalAmount += (Double(item.price ?? "0") ?? 0.0) * Double(item.productQuantity)
        }
        return totalAmount
    }
    
    @objc func deleteBtnTappedNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
           let productID = userInfo["productID"] as? Int {
            self.presenter?.deleteProductFromBasket(productID)
        }
    }
    
    @objc func plusBtnTappedNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
           let productID = userInfo["productID"] as? Int,
           let quantity = userInfo["quantity"] as? Int {
            self.presenter?.updateProductQuantity(actionType: .increaseProductQuantity, productID: productID, quantity: quantity)
        }
    }
    
    @objc func minusBtnTappedNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
           let productID = userInfo["productID"] as? Int,
           let quantity = userInfo["quantity"] as? Int {
            if quantity.isEqualToOne { self.presenter?.deleteProductFromBasket(productID) }
            self.presenter?.updateProductQuantity(actionType: .descreaseProductQuantity, productID: productID, quantity: quantity)
        }
    }
    
    @objc func onBuyNowBtnClicked() {
        let alert = UIAlertController(title: "UIAlertController", message: "Continue?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.destructive, handler: {_ in
            self.presenter?.deleteAllProductFromBasket() {
                self.dismiss(animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketCell
        let item = basketItems[indexPath.row]
        cell.setup(item: item)
        
        return cell
    }
        
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.routeToProductDetail(productID: Int(basketItems[indexPath.row].productID))
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}
