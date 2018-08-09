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
        
        for i in 0..<categorys.count{
            
            var mUrls: [LPLinkModel] = []
            for j in 0..<urls.count { //전체유알엘에서
                
                if urls[j].category?.name == categorys[i].name {
                    mUrls.append(urls[j])
                }
                let mCategoryListObject = LPCategoryListObject(frame: rR(CGFloat(40 + ((100+16)*(i+1))),0,100,42), categroyN: categorys[i].name!, urls: mUrls)
                self.scrollV.addSubview(mCategoryListObject)
                //mCategoryListObject.Shadow(color: UIColor.colorFromRGB(0xe4e4e4), opacity: 0.2, offSet: CGSize(width: 0.1, height: 0.1), radius: 20*r, scale: true)
                
                mCategoryListObject.listener = { urls in
                    self.listener?.displayCategoryTable(categoryN: categorys[i].name!, urls: urls)
                    
                    for sv in self.scrollV.subviews {
                        if sv is LPCategoryListObject && (sv as! LPCategoryListObject).categoryN != categorys[i].name  {
                            (sv as! LPCategoryListObject).onUnclicked()
                        }
                    }
                    
                }
                scrollVw = CGFloat(80 + ((85+16)*(i+2)))
            }
            
            mUrls.removeAll()
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
