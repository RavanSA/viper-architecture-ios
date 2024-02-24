//
//  SearchViewController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var searchProductsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let productsNib = UINib(nibName: "SearchCategoriesCell", bundle: nil)
        
        self.categoriesCollectionView.register(productsNib, forCellWithReuseIdentifier: "searchCategoriesCell")
        
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
    }

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCategoriesCell", for: indexPath) as! SearchCategoriesCell
        cell.backgroundColor = .lightGray

        let categoryItem = categoriesItems[indexPath.item]
        cell.setup(item: categoryItem)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 0
        let availableWidth = collectionView.bounds.width - itemSpacing * 2
        
        let categoryItem = categoriesItems[indexPath.item]
        
        let categoryNameWidth = categoryItem.categoryName.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ]).width
        let cellWidth = categoryNameWidth + 20
        
        let finalCellWidth = min(cellWidth, availableWidth)
        return CGSize(width: finalCellWidth, height: 30)
    }
    
}
