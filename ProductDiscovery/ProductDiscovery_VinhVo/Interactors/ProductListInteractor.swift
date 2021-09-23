//
//  ProductListInteractor.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import Foundation
import Combine
import Networking

protocol ProductListInteractorDelegate: class {
    func getProductListSuccesfully()
    func getProductListFailed()
}

class ProductListInteractor: NSObject {
    
    weak var delegate: ProductListInteractorDelegate?

    let productProvider = ProductProvider()
    let cachedProductProvider = CachedProductProvider()
    
    //variable
    var cancellables = Set<AnyCancellable>()
    var products = [Product]()
    
    
    func getProductList() {
        if NetworkManager.sharedInstance.reach?.isReachable == false {
            getLocalProductList()
        } else {
            getNetworkProductList()
        }
    }
    
    func getNetworkProductList() {
        cancellables.forEach { (cancellable) in
            cancellable.cancel()
        }
        productProvider.getProductList().sink(receiveCompletion: { completion in
        switch completion {
            case .finished:
                break
            case .failure(let error):
                Debug.print(error.localizedDescription)
                if error.localizedDescription == "notConnectedToInternet" {
                    self.getLocalProductList()
                } else {
                    self.delegate?.getProductListFailed()
                }
            }
        }) { (products) in
            self.products = products
            self.saveDataToLocalDB(products)
            self.delegate?.getProductListSuccesfully()
        }.store(in: &cancellables)
    }
    
    func saveDataToLocalDB(_ products: [Product]) {
        cachedProductProvider.save(products: products)
    }
    
    func getLocalProductList() {
        self.products = cachedProductProvider.getAllCachedProduct() ?? []
        self.delegate?.getProductListSuccesfully()
    }
    
    func getLocalProductListBy(strSearch: String) {
        self.products = cachedProductProvider.getCachedProductBy(strSearch: strSearch) ?? []
        self.delegate?.getProductListSuccesfully()
    }
    
}
