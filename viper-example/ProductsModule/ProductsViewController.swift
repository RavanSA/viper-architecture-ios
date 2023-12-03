//
//  ProductsViewController.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import UIKit

class ProductsViewController: UIViewController, ProductsViewControllerProtocol {

    @IBOutlet weak var welcomeTxt: UILabel!
    @IBOutlet weak var userInformation: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!

    var presenter: ProductsPresenterProtocol?
    var products: ProductsDTO?
    
    private var numberOfItemsInRow = 2

    private var minimumSpacing = 5

    private var edgeInsetPadding = 10
    
    var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.backgroundColor = .clear
        return scrollview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductsRouter.createModule(vc: self)

        let categoryNib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        let productsNib = UINib(nibName: "ProductsCell", bundle: nil)

        self.categoriesCollectionView.register(categoryNib, forCellWithReuseIdentifier: "categoriesCell")
        self.productsCollectionView.register(productsNib, forCellWithReuseIdentifier: "productsCell")
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        setupScrollView()
        presenter?.fetchProducts()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    func fetchedProductsSuccesfully(response: ProductsDTO) {
        self.products = response
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
    
    func fetchedProductsFailed() {
        
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
            return CGSize(width: 60, height: 100)
        }
    }
    
}


extension ProductsViewController : UIScrollViewDelegate {
    
    func setupScrollView() {
        scrollview.delegate = self
        view.addSubview(scrollview)
    }
}

class SecondViewController: UIViewController {
    let label = createLabel(str: "Settings Page")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "Settings"
        view.addSubview(label)
        label.center = view.center
    }
}

class ThirdViewController: UIViewController {
    
    let label = createLabel(str: "About Page")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "About"
        view.addSubview(label)
        label.center = view.center
    }
}


func createLabel(str : String) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    label.text = "\(str)"
    label.font = UIFont(name: label.font.familyName, size: 50)
    label.textAlignment = .center
    label.textColor = .white
    return label
}
