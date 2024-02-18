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
    
    var presenter: BasketPresenterProtocol?
    
    private var disposeBag = DisposeBag()
    private var basketItems: [Basket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BasketRouter.createModule(vc: self)
        title = "Basket"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let basketCellNib = UINib(nibName: "BasketCell", bundle: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(basketCellNib, forCellReuseIdentifier: "basketCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBtnTappedNotification), name: Notification.Name("DeleteBtnTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(plusBtnTappedNotification), name: Notification.Name("PlusBtnTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(minusBtnTappedNotification), name: Notification.Name("MinusBtnTapped"), object: nil)
        
        observeBasket()
    }
    
    private func observeBasket() {
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
    
    private func computeTotalAmount(basket: [Basket]) -> Int {
        var totalAmount = 0
        basket.forEach { item in
            totalAmount += (Int(item.price ?? "0") ?? 0) * Int(item.productQuantity)
        }
        return totalAmount
    }
    
    @objc func deleteBtnTappedNotification() {
        print("deleteBtnTappedNotification tapped from cell in ViewController")
    }
    
    @objc func plusBtnTappedNotification() {
        print("plusBtnTappedNotification tapped from cell in ViewController")
    }
    
    @objc func minusBtnTappedNotification() {
        print("minusBtnTappedNotification tapped from cell in ViewController")
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
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item: \(basketItems[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}
