//
//  LPSearchCategoryListObject.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchCategoryListObject: View {
    
    var color: UIView!
    var label: UILabel!
    
    init(frame: CGRect, category: LPCategoryModel) { // (width: 70, height: 55)
        super.init(frame: frame)
        
        color = UIView(frame: rR( 20, 0, 30, 30))
        color.backgroundColor = UIColor.init(red: CGFloat(category.r!), green: CGFloat(category.g!), blue: CGFloat(category.b!), alpha: CGFloat(category.alpha!))
        addSubview(color)
        color.layer.cornerRadius = color.bounds.height / 2
        color.isUserInteractionEnabled = false
        
        label = UILabel(frame: rR( 0, 39, bounds.width, 16))
        label.text = category.name
        label.font = UIFont(name: "Roboto-Medium", size: 13 * r)
        label.textAlignment = .center
        label.textColor = UIColor.colorFromRGB(0x6C6C6C)
        addSubview(label)
        label.isUserInteractionEnabled = false
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
