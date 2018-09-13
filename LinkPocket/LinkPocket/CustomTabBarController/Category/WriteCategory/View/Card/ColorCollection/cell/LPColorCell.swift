//
//  LPColorCell.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 27..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPColorCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIImageView!
    var selectedColor = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = colorView.bounds.height/2
    }
    
    func onClicked(){
        colorView.image = UIImage(named: "LPCheck")
    }
    
    func onUnclicked(){
        colorView.image = UIImage(named: "")
    }
    
    func modifyCell(color: UIColor) {
        colorView.backgroundColor = color
        selectedColor = color
    }

}
