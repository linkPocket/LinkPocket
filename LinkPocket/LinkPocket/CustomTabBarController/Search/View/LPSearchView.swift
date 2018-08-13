//
//  LPSearchView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchView: UIView {
    
    var mSearchBar: UIView!
    var mSearchCategoryList: LPSearchCategoryList!
    
    init(frame: CGRect, categorys: [LPCategoryModel]) {
        super.init(frame: frame)
        
        mSearchBar = UIView(frame: rR(0,0,W,40)) //이거 임시 써치바
        addSubview(mSearchBar)
        
        let line1 = UIView(frame: rR(0,40,W,1))
        line1.backgroundColor = wColor
        addSubview(line1)
        
        mSearchCategoryList = LPSearchCategoryList(frame: rR(0, 41, W, 77), categorys: categorys)
        addSubview(mSearchCategoryList)
        
        let line2h = (41*r)+mSearchCategoryList.bounds.height
        let line2 = UIView(frame: R(0,line2h,W,10))
        line2.backgroundColor = wColor
        addSubview(line2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
