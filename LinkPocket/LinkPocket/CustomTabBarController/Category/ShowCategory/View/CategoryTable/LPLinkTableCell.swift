//
//  LPLinkTableCell.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 20..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPLinkTableCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var category: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func modifyCell(img: String, url: String, title: String, category: LPCategoryModel){
        
        self.img.image = UIImage(named: "Naver")
        self.title.text = title
        self.url.text = url
        self.category.text = "\(category.name!)           "
        self.category.backgroundColor = UIColor.red
        self.category.layer.masksToBounds = true
        self.category.layer.cornerRadius = 6.5 * r
        
    }
    
}
