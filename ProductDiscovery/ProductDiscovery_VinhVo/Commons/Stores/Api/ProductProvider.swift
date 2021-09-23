//
//  ProductProvider.swift
//  BankClub
//
//  Created by Vinh Vo on 5/18/18.
//  Copyright © 2018 Vinh Vo. All rights reserved.
//

import UIKit
import Networking
import Combine

struct ProductProvider: NetworkingService {
    
    var network = NetworkingClient(baseURL: Config.baseURL)
    
    init() {
        network.logLevels = .debug
    }

    func getProductList() -> AnyPublisher<[Product], Error> {
        get("/7af6f34b-b206-4bed-b447-559fda148ca5")
    }
}
