//
//  LPSearchTableCell.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 17..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchTableCell: UITableViewCell {
    
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        circle.layer.cornerRadius = circle.bounds.height/2
    }
    
    func modifyCell(color: UIColor, categoryN: String) {
        circle.backgroundColor = color
        label.text = categoryN
    }
    
}

