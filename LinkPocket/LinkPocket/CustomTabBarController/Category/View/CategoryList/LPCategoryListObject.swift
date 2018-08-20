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
    var listener: (([LPLinkModel]) -> ())?
    
    var categoryNL: UILabel!
    var urlCountL: UILabel!
    let fontC = UIColor.colorFromRGB(0x707070)
    
    var urls: [LPLinkModel] = []
    init(frame: CGRect, categroyN: String, urls: [LPLinkModel]) { // categoryName, urlCount(갯수)
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = UIColor.colorFromRGB(0xfdfdfd)
        self.layer.cornerRadius = 2*r
        self.urls = urls
        self.categoryN = categroyN
        let w = self.bounds.width
        
        categoryNL = UILabel(frame: rR(0,7.26,w,16))
        categoryNL.text = categoryN
        categoryNL.textAlignment = .center
        categoryNL.font = UIFont(name: "Roboto-Bold", size: 12*r)
        categoryNL.textColor = fontC
        urlCountL = UILabel(frame: rR(0,24.12,w,11))
        urlCountL.text = "\(urls.count)"
        urlCountL.font = UIFont(name: "Roboto-Medium", size: 9*r)
        urlCountL.textColor = fontC
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
            self.layer.cornerRadius = 2*r
            self.backgroundColor = UIColor.colorFromRGB(0x008EFF)
            self.categoryNL.textColor = UIColor.white
            self.urlCountL.textColor = UIColor.white
        })
        self.listener?(urls)
        self.clickIndex = 1
    }
    
    public func onUnclicked(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 2*r
            self.backgroundColor = UIColor.colorFromRGB(0xf5f5f5)
            self.categoryNL.textColor = self.fontC
            self.urlCountL.textColor = self.fontC
        })
        self.clickIndex = 0
        
    }
    
}
