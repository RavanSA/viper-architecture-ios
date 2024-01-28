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
    @IBOutlet weak var bannerView: UIView!
    

    // MARK: Properties
    var presenter: ProductsPresenterProtocol?
    var products: ProductsDTO?

    var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.backgroundColor = .clear
        return scrollview
    }()

    private let refreshControl = UIRefreshControl()


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
        
        refreshControl.addTarget(self, action: #selector(onRefreshClicked), for: .valueChanged)

            let refreshControlContainer = UIScrollView()
            refreshControlContainer.refreshControl = refreshControl
            view.addSubview(refreshControlContainer)
        bannerView.layer.cornerRadius = 10
        
        presenter?.fetchProducts()
    }

    @objc func onRefreshClicked() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshControl.endRefreshing()
        }
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
//            let shadowLayer = CALayer()
//
            cell.layer.cornerRadius = 10
//            shadowLayer.frame = cell.bounds
//            shadowLayer.backgroundColor = UIColor.black.cgColor
//            shadowLayer.shadowColor = UIColor.black.cgColor
//            shadowLayer.shadowOpacity = 1
//            shadowLayer.shadowRadius = 4
//            shadowLayer.masksToBounds = false
//            
//            // Add shadow for each side
//            let shadowPath = UIBezierPath(rect: cell.bounds.insetBy(dx: -2, dy: -2))
//            shadowLayer.shadowPath = shadowPath.cgPath
//            
//            cell.layer.insertSublayer(shadowLayer, at: 0)
            
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
            let spacing: CGFloat = 20
            let numberOfColumns: CGFloat = 2
            
            let totalWidth = collectionView.bounds.width - (spacing * (numberOfColumns - 1))
            
            let itemWidth = totalWidth / numberOfColumns
            
            let itemHeight: CGFloat = 200
            
            return CGSize(width: itemWidth, height: itemHeight)
        } else {
            return CGSize(width: 80, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == productsCollectionView {
            return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        } else if collectionView == categoriesCollectionView {
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        } else {
            return UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 10)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == productsCollectionView {
            return 0 // Adjust this value as needed
        } else {
            return 0 // No space between items for other collection views
        }
    }

    
}
