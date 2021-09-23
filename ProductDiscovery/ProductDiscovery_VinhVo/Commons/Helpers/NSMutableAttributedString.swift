//
//  NSMutableAttributedString.swift
//  EverydayRacism
//
//  Created by Vinh Vo on 8/8/17.
//  Copyright © 2017 Vinh Vo. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {

    @discardableResult func bold(_ text:String, font: UIFont) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key:AnyObject] = [.font : font]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }

    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }

    func highlightTarget(target: String, backgroundColor: UIColor = .clear, textColor: UIColor = .black) -> NSMutableAttributedString {
        
        let lwTarget = target.lowercased()
        if let regex = try? NSRegularExpression(pattern: lwTarget, options: []) {
            let matchesArray = regex.matches(in: self.string.lowercased(), options: [], range: NSRange(location: 0, length: self.length))
            for match in matchesArray {
                let substring = String(self.string.substring(with: match.range) ?? "")
                let attributedText = NSMutableAttributedString(string: substring)
                attributedText.addAttribute(.backgroundColor, value: backgroundColor, range: NSRange(location: 0, length: attributedText.length))
                attributedText.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: attributedText.length))
                self.replaceCharacters(in: match.range, with: attributedText)
            }
        }
        return self
        
    }

}
