//
//  LPCategoryView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryV: UIView, LPCategoryListListener {
    
    var mCategoryList: LPCategoryList!
    var mCategoryTable: LPCategoryTable!
    
    init(frame: CGRect, categorys: [LPCategoryModel], urls: [LPLinkModel]) {
        super.init(frame: frame)
        
        mCategoryList = LPCategoryList(frame: rR( 0, 0, W, 84), categorys: categorys, urls: urls) //수정 필요
        mCategoryList.listener = self
        self.addSubview(mCategoryList)
        
        mCategoryTable = LPCategoryTable(frame: rR( 0, 80, W, H-80))
        self.addSubview(mCategoryTable)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayCategoryTable(categoryN: String, urls: [LPLinkModel]) {
        mCategoryTable.displayTableContent(categoryN: categoryN, urls: urls)
    }
    
    func addCategory() {
        print("카테고리를 추가해주세요")
    }
    
}
