//
//  ProductsViewController.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import UIKit

class ProductsViewController: UIViewController, ProductsViewControllerProtocol {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var welcomeTxt: UILabel!
    @IBOutlet weak var userInformation: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var categoriesHeaderLabel: UILabel!
    @IBOutlet weak var categoriesCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoriesHeaderLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImage: UIImageView!
    
    // MARK: Properties
    var presenter: ProductsPresenterProtocol?
    
    var products: ProductsDTO? {
        didSet {
            filteredproducts = products
        }
    }
    
    var filteredproducts: ProductsDTO?

    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController(searchResultsController: nil)

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

}

// MARK: - Functions
extension ProductsViewController {
    
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
        
        let refreshControlContainer = self.scrollView
        refreshControlContainer?.refreshControl = refreshControl
        
        if let container = refreshControlContainer {
            view.addSubview(container)
        }
        
        bannerView.layer.cornerRadius = 10
        
        setupNavigationBar()
        
        presenter?.fetchProducts()
    }
    
    private func setupNavigationBar() {
        let leftIconButton = UIButton(type: .custom)
        leftIconButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let leftIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftIconImageView.tintColor = .black
        leftIconImageView.image = UIImage(systemName: "basket")
        leftIconImageView.contentMode = .scaleAspectFit
        
        leftIconButton.addSubview(leftIconImageView)
        
        leftIconButton.addTarget(self, action: #selector(firstItemTapped), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftIconButton)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        searchController.searchBar.tintColor = .white
        searchController.hidesNavigationBarDuringPresentation = true
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.sizeToFit()
        
        title = "Welcome"
        
        definesPresentationContext = true
    }

    @objc func onRefreshClicked() {
        presenter?.fetchProducts()
    }
    
    @objc func firstItemTapped() {
        presenter?.routeToBasket()
    }
    
    func fetchedProductsSuccesfully(response: ProductsDTO) {
        self.products = response
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func fetchedProductsFailed() {
        showMessage("Error!", title: "Error Occured")
    }
    
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productsCollectionView {
            return filteredproducts?.count ?? 0
        } else {
            return categories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView {
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! ProductsCollectionViewCell
            cell.productImage.image = UIImage(named: "placeholder")

            let productItem = filteredproducts?[indexPath.row]
            
            cell.layer.cornerRadius = 10

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

            if let selectedProductID = filteredproducts?[indexPath.row].id {
                
                let productDetailVC = ProductDetailViewController()
                productDetailVC.productID = selectedProductID
                navigationController?.pushViewController(productDetailVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == productsCollectionView {
            return 0
        } else {
            return 0
        }
    }

}

extension ProductsViewController:  UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            
            filteredproducts = products?.filter { $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.description.lowercased().contains(searchText.lowercased())
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.categoriesCollectionViewHeightConstraint.constant = 0
                self.bannerViewHeightConstraint.constant = 0
                self.categoriesHeaderLabelHeightConstraint.constant = 0
                self.bannerImage.isHidden = true
                self.productsCollectionView.reloadData()
            })
        } else {
            filteredproducts = products

            UIView.animate(withDuration: 0.5, animations: {
                self.categoriesCollectionViewHeightConstraint.constant = 150
                self.bannerViewHeightConstraint.constant = 165
                self.categoriesHeaderLabelHeightConstraint.constant = 30
                self.bannerImage.isHidden = false
                self.productsCollectionView.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredproducts = products
        UIView.animate(withDuration: 0.5, animations: {
            self.categoriesCollectionViewHeightConstraint.constant = 150
            self.bannerViewHeightConstraint.constant = 165
            self.categoriesHeaderLabelHeightConstraint.constant = 30
            self.bannerImage.isHidden = false
            self.productsCollectionView.reloadData()
        })
    }
    
}
