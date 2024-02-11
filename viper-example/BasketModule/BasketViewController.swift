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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BasketRouter.createModule(vc: self)
        title = "Basket"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        observeBasket()
    }

    private func observeBasket() {
        presenter?.onAllProductsFromBasket()?
            .subscribe(onNext: { [weak self] basket in
                guard let self = self else { return }
                self.itemCount.text = "Total \(basket.count) items"
                self.itemAmount.text = "\(computeTotalAmount(basket: basket)) USD"
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
    
}
