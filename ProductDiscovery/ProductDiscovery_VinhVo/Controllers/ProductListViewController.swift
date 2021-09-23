//
//  ProductListViewController.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import UIKit

class ProductListViewController: BaseViewController<ProductListView> {

    var interactor: ProductListInteractor?
    
    init(interactor: ProductListInteractor?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view
        mainView.setupSearchBarWith(navigatorItem: self.navigationItem)
        mainView.vwSearchBar.delegate = self
        mainView.vwCollection.delegate = self
        mainView.vwCollection.dataSource = self
        mainView.refreshControl.beginRefreshing()
        mainView.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        //interactor
        interactor?.delegate = self
        interactor?.getProductList()
    }
    
   
    //MARK: - Actions
    @objc func searchData() {
        Debug.print(mainView.vwSearchBar.text ?? "")
        interactor?.getLocalProductListBy(strSearch: mainView.vwSearchBar.text ?? "")
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        interactor?.getProductList()
    }
    
    override func dismissKeyboard() {
        mainView.vwSearchBar.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - UICollectionViewDataSource && UICollectionViewFlowLayoutDelegate
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Config.screenWidth, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        if let product = interactor?.products[indexPath.row] {
            cell.product = product
            cell.setHightLine(searchString: mainView.vwSearchBar.text ?? "")
        }
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainView.vwSearchBar.endEditing(true)
    }
    
    //MARK: Action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}


//MARK: - UISearchBar Delegate
extension ProductListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // throttle 0.5s
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchData), object: nil)
        self.perform(#selector(searchData), with: nil, afterDelay: 0.5)
     }
}


//MARK: - ProductListInteractorDelegate
extension ProductListViewController: ProductListInteractorDelegate {
    func getProductListSuccesfully() {
        mainView.didLoadedData()
    }
    
    func getProductListFailed() {
        showMessage("get product list failed", type: .error)
        mainView.didLoadedData()
    }
}
