//
//  ProductListView.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import UIKit
import SnapKit
import Localize_Swift

class ProductListView: BaseView {

    // Custom initializers go here
    var refreshControl = UIRefreshControl()

    let vwSearchBar = UISearchBar().then { (searchBar) in
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = "tf_search".localized()
        searchBar.searchTextField.font = Fonts.textRegular
        searchBar.searchTextField.leftView?.tintColor = Colors.tomato
    }

    let vwCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.registerCellClass(ProductCollectionViewCell.self)
        collectionView.backgroundColor = Colors.gray
        return collectionView
    }()
    
    
    // MARK: - View Lifecycle
    override func setViews() {
        self.backgroundColor = .white
        self.addSubview(vwCollection)
        vwCollection.addSubview(refreshControl)
    }
    
    func setupSearchBarWith(navigatorItem: UINavigationItem) {
        navigatorItem.titleView = vwSearchBar
    }

    
    //MARK: - layout views
    override func layoutViews() {
        vwCollection.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-Constants.safePadding)
        }
    }
    
    
    //MARK: - functions
    func didLoadedData() {
        vwCollection.reloadData()
        refreshControl.endRefreshing()
    }
    

}
