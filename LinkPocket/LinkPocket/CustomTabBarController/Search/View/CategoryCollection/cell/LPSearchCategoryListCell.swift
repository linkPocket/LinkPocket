//
//  LPSearchCategoryListObject.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchCategoryListCell: UICollectionViewCell {

    @IBOutlet weak var color: UIView!
    @IBOutlet weak var label: UILabel!
    
    var categoryN: String = ""
    var urls: [LPLinkModel] = []
    
    override func awakeFromNib() {
        color.layer.cornerRadius = color.bounds.height/2
    }
    
    func modifyCell(color: UIColor, categoryN: String, urls: [LPLinkModel] ) {
    
        self.color.backgroundColor = color
        self.categoryN = categoryN
        self.urls = urls
        label.text = categoryN
        
    }
    
}
