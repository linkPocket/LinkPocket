//
//  LPCategoryListObject.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryListCell: UICollectionViewCell {
    @IBOutlet weak var categoryNL: UILabel!
    @IBOutlet weak var urlCountL: UILabel!
    
    var urls: [LPLinkModel] = []
   
    func modifyCell(categoryN: String, urlCount: String) {
        categoryNL.text = categoryN
        urlCountL.text = urlCount
    }

    let fontC = UIColor.colorFromRGB(0x707070)
    
    func onClicked(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 2*r
            self.backgroundColor = UIColor.colorFromRGB(0x008EFF)
            self.categoryNL.textColor = UIColor.white
            self.urlCountL.textColor = UIColor.white
        })
    }
    
    func onUnclicked(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 2*r
            self.backgroundColor = UIColor.white
            self.categoryNL.textColor = self.fontC
            self.urlCountL.textColor = self.fontC
        })
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.onClicked()
            } else {
                self.onUnclicked()
            }
        }
    }

}
