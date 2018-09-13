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
    
    func modifyCell(img: String, url: String, title: String, color: UIColor ,category: LPCategoryModel){
        if let data = try? Data(contentsOf: URL(string: img)!)
        {
            self.img.image = UIImage(data: data)
        }
        self.title.text = title
        self.url.text = url
        self.category.text = "\(category.name!)           "
        self.category.backgroundColor = color
        self.category.layer.masksToBounds = true
        self.category.layer.cornerRadius = self.category.bounds.height/2
        
        self.img.backgroundColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1)
        self.img.layer.cornerRadius = 8.0
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 1
        self.img.layer.borderColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1).cgColor

    }
}
