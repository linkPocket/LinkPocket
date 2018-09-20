//
//  LPSearchCategoryListObject.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchCategoryListCell: UICollectionViewCell {

    @IBOutlet weak var color: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var categoryN: String = ""
    var urls: [LPLinkModel] = []
    var usePlace: String = "Search" // "Search" || "Edit"
    
    override func awakeFromNib() {
        color.layer.cornerRadius = color.bounds.height/2
    }
    
    func modifyCell(color: UIColor, categoryN: String, urls: [LPLinkModel], usePlace: String ) {
    
        self.color.backgroundColor = color
        self.categoryN = categoryN
        self.urls = urls
        self.usePlace = usePlace
        label.text = categoryN
        
    }
    
    override var isSelected: Bool {
        didSet {
            if usePlace == "Edit" {
            if self.isSelected {
                self.onClicked()
            } else {
                self.unClicked()
            }
            }
        }
    }
    
    func onClicked() {
        self.color.image = UIImage(named: "LPCheck")
    }

    func unClicked() {
        self.color.image = UIImage(named: "")
    }
    
}
