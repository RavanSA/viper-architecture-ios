//
//  SearchViewController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, SearchViewControllerProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var searchProductsTableView: UITableView!
    
    var presenter: SearchPresenter?
    var products: [ProductsEntity] = []
    var filteredProducts: [ProductsEntity] = []
    var categories: [String] = []
    
    private var disposeBag = DisposeBag()
    private let searchTextSubject = PublishSubject<String>()
    
    private lazy var searchTextObservable = searchBar.rx.text.orEmpty
        .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .asObservable()

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchRouter.createModule(vc: self)
        
        setupUI()
    }
    
}

extension SearchViewController {
    private func setupUI() {
        let categoriesNib = UINib(nibName: "SearchCategoriesCell", bundle: nil)
        let productsNib = UINib(nibName: "SearchProductsCell", bundle: nil)

        categoriesCollectionView.register(categoriesNib, forCellWithReuseIdentifier: "searchCategoriesCell")
        searchProductsTableView.register(productsNib, forCellReuseIdentifier: "searchProductCell")

        searchProductsTableView.dataSource = self
        searchProductsTableView.delegate = self
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        searchBar.delegate = self
        
        subscribeSearchTextChanges()
        showActivityIndicator()
        presenter?.fetchCategories()
    }
    
    private func subscribeSearchTextChanges() {
        
        guard let products = presenter?.getAllProducts() else {
            return
        }
        
        Observable.combineLatest(searchTextObservable, products) { searchText, products in
                if searchText.isEmpty {
                    return products
                } else {
                    return products.filter { product in
                        return product.productDescription?.lowercased().contains(searchText.lowercased()) ?? false ||
                        product.title?.lowercased().contains(searchText.lowercased()) ?? false
                    }
                }
            }
            .subscribe(onNext: { [weak self] filteredProducts in
                guard let self = self else { return }
                self.products = filteredProducts
                self.filteredProducts = self.products
                searchProductsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func fetchedCategoriesSuccesfully(response: [String]) {
        DispatchQueue.main.async {
            self.categories = response
            self.categoriesCollectionView.reloadData()
            self.hideActivityIndicator()
        }
    }
    
    func fetchedCategoriesFailed() {
        showMessage("Error Occured", title: "Error!", view: self)
        self.hideActivityIndicator()
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCategoriesCell", for: indexPath) as! SearchCategoriesCell
        cell.backgroundColor = .lightGray

        let categoryItem = categories[indexPath.item]
        cell.setup(item: categoryItem)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 0
        let availableWidth = collectionView.bounds.width - itemSpacing * 2
        
        let categoryItem = categories[indexPath.item]
        
        let categoryNameWidth = categoryItem.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ]).width
        
        let cellWidth = categoryNameWidth + 20
        
        let finalCellWidth = min(cellWidth, availableWidth)
        return CGSize(width: finalCellWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCategory = categories[indexPath.item]
        
        guard !selectedCategory.elementsEqual("All") else {
            filteredProducts = products
            searchProductsTableView.reloadData()
            return
        }
        
        filteredProducts = products.filter { product in
            return product.category?.elementsEqual(selectedCategory) ?? false
        }
        
        searchProductsTableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchProductCell", for: indexPath) as! SearchProductsCell
        let item = filteredProducts[indexPath.row]
        cell.setup(item: item)
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProductID = filteredProducts[indexPath.row].id
        presenter?.routeToProductDetail(productID: Int(selectedProductID))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextSubject.onNext(searchText)
    }
}
