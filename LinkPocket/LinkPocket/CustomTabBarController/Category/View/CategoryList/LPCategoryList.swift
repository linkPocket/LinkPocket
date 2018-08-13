//
//  LPCategoryList.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol LPCategoryListListener {
    func displayCategoryTable(categoryN: String, urls: [LPLinkModel])
    func addCategory()
}

class LPCategoryList: UIView {
    
    var categorysN: [LPLinkModel] = []
    var listener: LPCategoryListListener!
    
    var scrollV: UIScrollView!
    var scrollVw: CGFloat = 0
    init(frame: CGRect, categorys: [LPCategoryModel], urls: [LPLinkModel]) {
        super.init(frame: frame)
        
        scrollV = UIScrollView(frame: bounds)
        scrollV.contentSize = CGSize(width: 0, height: 0)
        addSubview(scrollV)
        
        let bt = ImageView(frame: rR(40,0,100,42), named: "add")
        bt.backgroundColor = UIColor.colorFromRGB(0xfdfdfd)
        scrollV.addSubview(bt)
        
        bt.onClick = {
            self.listener?.addCategory()
        }
        
        for i in 0..<categorys.count {
            let mUrls = urls.filter { $0.category?.name == categorys[i].name }
            let mCategoryListObject = LPCategoryListObject(frame: rR(CGFloat(40 + ((100 + 16) * (i + 1))), 0, 100, 42), categroyN: categorys[i].name!, urls: mUrls)
            self.scrollV.addSubview(mCategoryListObject)
            
            mCategoryListObject.listener = { urls in
                self.listener?.displayCategoryTable(categoryN: categorys[i].name!, urls: urls)
                
                for sv in self.scrollV.subviews {
                    if let subView = sv as? LPCategoryListObject, subView.categoryN != categorys[i].name {
                        subView.onUnclicked()
                    }
                }
              //  mCategoryListObject.frame = R(self.bounds.origin.x, mCategoryListObject.frame.origin.y, mCategoryListObject.frame.width, mCategoryListObject.frame.height)
            }
            
            
            
            scrollVw = CGFloat(80 + ((85 + 16) * (i + 2)))
        }
        
        let h = self.bounds.height
        scrollV.contentSize = CGSize(width: scrollVw, height: h)
        let underV = UIView(frame: R(0,h-10,self.bounds.width,10))
        underV.backgroundColor = UIColor.white
        addSubview(underV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
