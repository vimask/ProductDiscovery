//
//  BaseView.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Set view and its subviews
    func setViews() {
        self.backgroundColor = .white
    }
    
    /// layout subviews
    func layoutViews() {
        
    }
}
