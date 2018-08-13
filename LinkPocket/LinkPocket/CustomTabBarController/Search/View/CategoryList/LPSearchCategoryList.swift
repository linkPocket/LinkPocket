//
//  LPCategoryList.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchCategoryList: UIView { // (width: W, height: 77)
    
    var scrollV: UIScrollView!
    var scrollVw: CGFloat = 0
    init(frame: CGRect, categorys: [LPCategoryModel]) {
        super.init(frame: frame)
        
        scrollV = UIScrollView(frame: bounds)
        scrollV.contentSize = CGSize(width: 0, height: 0)
        addSubview(scrollV)
        
        for i in 0..<categorys.count {
            let mLPSearCategoryListObject = LPSearchCategoryListObject(frame: rR(CGFloat(9 + (70 * i)), 11, 70, 55), category: categorys[i])
            addSubview(mLPSearCategoryListObject)
            
            scrollVw = CGFloat(9 + (70 * (i + 1)))
        }
        scrollV.contentSize = CGSize(width: scrollVw, height: 77*r)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
