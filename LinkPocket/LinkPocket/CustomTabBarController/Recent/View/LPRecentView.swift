//
//  LPRecentView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 9..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPRecentView: UIView {
    
    var mSearchBar: LPSearchBar!
    var mLPCategoryTable: LPCategoryTable!
    
    init(frame: CGRect, urls: [LPLinkModel]) {
        super.init(frame: frame)
        
        mSearchBar = LPSearchBar(frame: rR(0,0,W,40), urls: [], categorys: [])
        addSubview(mSearchBar)
        
        mLPCategoryTable = LPCategoryTable(frame: rR(0,50,W,self.bounds.height - 50), urls: urls)
        addSubview(mLPCategoryTable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
