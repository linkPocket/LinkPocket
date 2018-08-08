//
//  LPCategoryList.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol LPCategoryListListener {
    func displayCategoryTable(categoryN: String, urls: [CategoryModel])
    func addCategory()
}

class LPCategoryList: UIView {
    
    var categorysN: [CategoryModel] = []
    var listener: LPCategoryListListener!
    
    var scrollV: UIScrollView!
    var scrollVw: CGFloat = 0
    init(frame: CGRect, categoryNs: [String], categorys: [CategoryModel]) { //Sting -> LPCategoryModel
        super.init(frame: frame)
        
        scrollV = UIScrollView(frame: bounds)
        scrollV.contentSize = CGSize(width: 0, height: 0)
        addSubview(scrollV)
        
        let bt = ImageView(frame: rR(40,0,85,64), named: "add")
        bt.backgroundColor = UIColor.colorFromRGB(0xfdfdfd)
        scrollV.addSubview(bt)
        
        bt.onClick = {
            self.listener?.addCategory()
        }
        
        for i in 0..<categoryNs.count{
            
            var urls: [CategoryModel] = []
            for j in 0..<categorys.count { //전체유알엘에서
                
                if categorys[j].name == categoryNs[i] {
                    urls.append(testUrls[j])
                }
                let mCategoryListObject = LPCategoryListObject(frame: rR(CGFloat(40 + ((85+16)*(i+1))),0,85,64), categroyN: categoryNs[i], urls: urls)
                self.scrollV.addSubview(mCategoryListObject)
                
                mCategoryListObject.listener = { urls in
                    self.listener?.displayCategoryTable(categoryN: categoryNs[i], urls: urls)
                    
                    for sv in self.scrollV.subviews {
                        if sv is LPCategoryListObject && (sv as! LPCategoryListObject).categoryN != categoryNs[i]  {
                            (sv as! LPCategoryListObject).onUnclicked()
                        }
                    }
                    
                }
                scrollVw = CGFloat(80 + ((85+16)*(i+2)))
            }
            
            urls.removeAll()
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
