//
//  ProductCollectionViewCell.swift
//  ProductDiscovery_VinhVo
//
//  Created by vxvinh on 5/26/21.
//

import UIKit
import SnapKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    var product: Product? {
        didSet {
            if let url = URL(string: product?.imageUrl ?? "") {
                imvAvatar.kf.setImage(
                    with: url,
                    placeholder: #imageLiteral(resourceName: "small"))
            }
            lbName.text = product?.name
            lbCode.text = "CODE: \(product?.code ?? "")"
            lbPrice.text = product?.price?.asLocaleCurrency
        }
    }
    
    let imvAvatar = UIImageView().then { (imv) in
        imv.layer.masksToBounds = true
        imv.image = #imageLiteral(resourceName: "small")
    }
    
    let lbName = UILabel(text: "name", font: Fonts.textRegular, textColor: .black)
        .then { (lb) in
            lb.numberOfLines = 2
    }
    let lbCode = UILabel(text: "code", font: Fonts.textRegular, textColor: .gray)
    let lbPrice = UILabel(text: "0.0", font: Fonts.textRegular, textColor: Colors.tomato)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    //MARK: Layout
    func setupViews() {
        
        self.backgroundColor = .white
        addSubViews(imvAvatar, lbName, lbCode, lbPrice)
        
        imvAvatar.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(12)
            make.bottom.equalTo(-12)
            make.height.equalTo(imvAvatar.snp.width)
        }
        
        lbName.snp.makeConstraints { (make) in
            make.left.equalTo(imvAvatar.snp.right).offset(12)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(imvAvatar)
        }
        
        lbCode.snp.makeConstraints { (make) in
            make.left.equalTo(imvAvatar.snp.right).offset(12)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(lbName.snp.bottom).offset(4)
        }
        
        lbPrice.snp.makeConstraints { (make) in
            make.left.equalTo(imvAvatar.snp.right).offset(12)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(lbCode.snp.bottom).offset(4)
        }
    }
    
    //MARK: - functions
    func setHightLine(searchString: String) {
        guard let name = lbName.text else { return}
        var attributedString = NSMutableAttributedString(string: name)
        let textInArray = searchString.split(separator: " ")
        for text in textInArray {
            attributedString = attributedString.highlightTarget(target: String(text), backgroundColor: Colors.yellow, textColor: UIColor.gray)
        }

        lbName.attributedText = attributedString
        lbName.textColor = .black
        lbName.font = Fonts.textRegular
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

