//
//  ProductsViewController.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import UIKit

class ProductsViewController: UIViewController, ProductsViewControllerProtocol {


    // MARK: Outlets
    @IBOutlet weak var welcomeTxt: UILabel!
    @IBOutlet weak var userInformation: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!


    // MARK: Properties
    var presenter: ProductsPresenterProtocol?
    var products: ProductsDTO?

    var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.backgroundColor = .clear
        return scrollview
    }()


    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductsRouter.createModule(vc: self)
        
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = false
    }

    private func setupUI() {
        let categoryNib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        let productsNib = UINib(nibName: "ProductsCell", bundle: nil)
        
        self.categoriesCollectionView.register(categoryNib, forCellWithReuseIdentifier: "categoriesCell")
        self.productsCollectionView.register(productsNib, forCellWithReuseIdentifier: "productsCell")
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        presenter?.fetchProducts()
    }

}

// MARK: - Functions
extension ProductsViewController {
    
    func fetchedProductsSuccesfully(response: ProductsDTO) {
        self.products = response
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
    
    func fetchedProductsFailed() {
        showMessage("Error!", title: "Error Occured")
    }
    
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productsCollectionView {
            return products?.count ?? 0
        } else {
            return categories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView {
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! ProductsCollectionViewCell
            let productItem = products?[indexPath.row]
            
            cell.layer.backgroundColor = UIColor.red.cgColor

            if let productItem {
                cell.setup(products: productItem)
            }
            
            return cell
        } else {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCollectionViewCell
            let categoryItem = categories[indexPath.row]
            
            cell.setup(category: categoryItem)
            return cell
        }
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productsCollectionView {
            let collectionViewWidth = collectionView.bounds.width/3.0
            let collectionViewHeight = collectionViewWidth + 30
            
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        } else {
            return CGSize(width: 80, height: 120)
        }
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 10) //
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsCollectionView {

            if let selectedProductID = products?[indexPath.row].id {
                
                let productDetailVC = ProductDetailViewController()
                productDetailVC.productID = selectedProductID
                navigationController?.pushViewController(productDetailVC, animated: true)
            }
        } else {
            // MARK: TODO
        }
    }
    
}
