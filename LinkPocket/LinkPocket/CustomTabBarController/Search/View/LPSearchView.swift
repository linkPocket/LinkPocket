//
//  LPSearchView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchView: UIView, SearchBarListener {

    var mSearchBar: LPSearchBar!
    var mSearchCategoryList: LPSearchCategoryList!
    var mSearchTable: LPSearchTable!
    
    init(frame: CGRect, urls: [LPLinkModel], categorys: [LPCategoryModel]) {
        super.init(frame: frame)
        
        mSearchBar = LPSearchBar(frame: rR(0,0,W,40), urls: urls, categorys: categorys)
        mSearchBar.listener = self
        addSubview(mSearchBar)
        
        let line1 = UIView(frame: rR(0,50,W,1))
        line1.backgroundColor = wColor
        addSubview(line1)
        
        mSearchCategoryList = LPSearchCategoryList(frame: rR(0, 51, W, 77), categorys: categorys)
        addSubview(mSearchCategoryList)
        
        let line2y = (51*r)+mSearchCategoryList.bounds.height
        let line2 = UIView(frame: R(0,line2y,W,10))
        line2.backgroundColor = wColor
        addSubview(line2)
        
        let mSearchTabley = line2y + line2.bounds.height
        mSearchTable = LPSearchTable(frame: R(0,mSearchTabley,W,self.bounds.height-mSearchTabley))
        addSubview(mSearchTable)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func FilteredReload(filteredData: [LPSearchModel]) {
        mSearchTable.reloadData(items: filteredData)
    }
}
