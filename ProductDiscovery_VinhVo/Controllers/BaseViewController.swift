//
//  BaseViewController.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import UIKit

class BaseViewController<V: BaseView>: UIViewController, UIGestureRecognizerDelegate {
    var hideKeyboardGesture: UIGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func loadView() {
        super.loadView()
        view = V()
    }
    
    var mainView:V {
        return view as! V
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardGesture = hideKeyboardWhenTappedAround()
        hideKeyboardGesture.delegate = self
    }
    
    //MARK: - UITapGestureDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if hideKeyboardGesture === gestureRecognizer {
            return !(touch.view is UIControl)
        }
        return true
    }
}

