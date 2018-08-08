//
//  LPCategoryListObject.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryListObject: View {
    
    var clickIndex = 0
    var categoryN = ""
    var listener: (([CategoryModel]) -> ())?
    
    var categoryNL: UILabel!
    var urlCountL: UILabel!
    
    var urls: [CategoryModel] = []
    init(frame: CGRect, categroyN: String, urls: [CategoryModel]) { // categoryName, urlCount(갯수)
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.colorFromRGB(0xfdfdfd)
        self.layer.cornerRadius = 5*r
        self.urls = urls
        self.categoryN = categroyN
        let w = self.bounds.width
        
        categoryNL = UILabel(frame: rR(0,18,w,16))
        categoryNL.text = categoryN
        categoryNL.textAlignment = .center
        urlCountL = UILabel(frame: rR(0,36,w,11))
        urlCountL.text = "\(urls.count)"
        urlCountL.textAlignment = .center
        
        addSubview(categoryNL); addSubview(urlCountL)
        
        self.onClick = {
            if self.clickIndex == 0 {
                self.onClicked()
            }
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func onClicked(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 10*r
            self.backgroundColor = UIColor.red
            self.categoryNL.textColor = UIColor.white
            self.urlCountL.textColor = UIColor.white
        })
        self.listener?(urls)
        self.clickIndex = 1
    }
    
    public func onUnclicked(){
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.cornerRadius = 5*r
            self.backgroundColor = UIColor.colorFromRGB(0xfdfdfd)
            self.categoryNL.textColor = UIColor.gray
            self.urlCountL.textColor = UIColor.gray
        })
        self.clickIndex = 0
        
    }
    
}
