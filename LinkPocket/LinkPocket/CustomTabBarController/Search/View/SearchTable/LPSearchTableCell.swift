//
//  LPSearchTableCell.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 17..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchTableCell: UITableViewCell {
    
    var mSearchTableCellCategory: LPSearchTableCellCategory!
    var mSearchTableCellUrls: LPSearchTableCellUrls!
    
}

class LPSearchTableCellCategory: UIView {
    init(frame: CGRect, category: LPCategoryModel) {
        super.init(frame: frame)
        
        let circle = UIView(frame: rR( 21, 16.5, 19, 19))
        addSubview(circle)
        circle.backgroundColor = UIColor.init(red: CGFloat(category.r!), green: CGFloat(category.g!), blue: CGFloat(category.b!), alpha: CGFloat(category.alpha!))
        circle.layer.cornerRadius = circle.bounds.width/2
        
        let label = UILabel(frame: rR(53,18.5,296,16))
        label.text = category.name!
        label.font = UIFont(name: "Roboto-Bold", size: 13 * r)
        label.textColor = UIColor.colorFromRGB(0x6C6C6C)
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LPSearchTableCellUrls: UIView {
    init(frame: CGRect, url: LPLinkModel) {
        super.init(frame: frame)
        
        let image = ImageView(frame: rR( 21, 16.5, 19, 19), named: url.imageName!)
        addSubview(image)
        image.backgroundColor = UIColor.lightGray // 임시 색깔
        
        let label = UILabel(frame: rR(53,18.5,296,16))
        label.text = url.url!
        label.font = UIFont(name: "Roboto-Bold", size: 13 * r)
        label.textColor = UIColor.colorFromRGB(0x6C6C6C)
        addSubview(label)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
