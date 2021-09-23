//
//  ViewExtension.swift
//  EverydayRacism
//
//  Created by Vinh Vo on 3/15/18.
//  Copyright © 2018 Vinh Vo. All rights reserved.
//

import UIKit
import GSMessages

//MARK: - UIViewController
extension UIViewController {

    @discardableResult
    func hideKeyboardWhenTappedAround() -> UITapGestureRecognizer {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        return tap
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func openLink(link: String) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string : link)!, options: [:], completionHandler: { (status) in
            })
        } else {
            UIApplication.shared.openURL(URL(string: link)!)
        }
    }


    open func showMessage(_ text: String,
                          type: GSMessageType,
                          options: [GSMessageOption]? = nil) {

        if type != GSMessageType.error {
            GSMessage.showMessageAddedTo(text: text, type: type, options: options, inView: view, inViewController: self)
            return
        }
        
        let alertView = UIAlertController(title: "Error",
                                            message: text,
                                            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Close", style: .default)
        alertView.addAction(okAction)
        self.present(alertView, animated: true)
        
    }

    open func showMessage(_ attributedText: NSAttributedString,
                          type: GSMessageType,
                          options: [GSMessageOption]? = nil) {

        GSMessage.showMessageAddedTo(attributedText: attributedText, type: type, options: options, inView: view, inViewController: self)
    }

    open func hideMessage(animated: Bool = true) {
        view.hideMessage(animated: animated)
    }


    typealias DidSelectResponse = (String?, Int) -> Void
    func showActionSheetFrom(sender: UIView, options: [String], cancels: [String]? = nil, extras: [String]? = nil, didSelected: @escaping DidSelectResponse ) {

        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)

        for (index,value) in options.enumerated() {
            let btAction: UIAlertAction = UIAlertAction(title: value, style: .default) { action -> Void in
                Debug.print("\(index)::\(value)")
                didSelected(value, index)
            }

            actionSheetController.addAction(btAction)
        }

        for (index,value) in (cancels ?? []).enumerated() {
            let btAction: UIAlertAction = UIAlertAction(title: value, style: .destructive) { action -> Void in
                didSelected(value, index)
            }
            actionSheetController.addAction(btAction)
        }

        //We need to provide a popover sourceView when using it on iPad
        //        var frame = sender.frame
        //        frame.size.width =  5
        //        actionSheetController.popoverPresentationController?.sourceRect = frame
        actionSheetController.popoverPresentationController?.sourceView = sender as UIView
        actionSheetController.popoverPresentationController?.sourceRect = sender.bounds;

        //Present the AlertController
        //        self.present(actionSheetController, animated: true, completion: nil)
        self.present(actionSheetController, animated: true) {

        }

    }

}

//MARK: - UIView
extension UIView {
    
    func addSubViews(_ subViews: UIView...) {
        subViews.forEach(addSubview)
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

//MARK: - UIIMAGE VIEW
extension UIImage {
    static func fromBundle(name: String) -> UIImage {
        if let filePath = Bundle.main.path(forResource: name, ofType: "") {
            return UIImage(contentsOfFile: filePath) ?? UIImage()
        }
        return UIImage()
    }
}

//MARK: - UILABEL
extension UILabel {
    
    convenience init(text: String, font: UIFont? = UIFont.systemFont(ofSize: 16), textColor: UIColor, textAlignment: NSTextAlignment? = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        if let textAlignment = textAlignment {
            self.textAlignment =  textAlignment
        }
    }
    
}


