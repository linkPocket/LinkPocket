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

    override func awakeFromNib() {
        color.layer.cornerRadius = color.bounds.height/2
    }
    
    func modifyCell(r: Double, g: Double, b: Double, alpha: Double, categoryN: String ) {
    
        let color = UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(alpha))
        self.color.backgroundColor = color
        
        label.text = categoryN
        
    }
    
    func onClicked(){
    }
    
    func onUnclicked(){
        
    }
    
}
