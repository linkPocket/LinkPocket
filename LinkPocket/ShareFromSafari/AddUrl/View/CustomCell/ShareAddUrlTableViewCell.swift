//
//  ShareAddUrlTableViewCell.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareAddUrlTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryColorImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    var categoryColor: UIColor? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func modifyCell(with categoryModel: LPCategoryModel) {
        guard let validColor = categoryModel.color() else { return }
        self.categoryColor = validColor
        
        DispatchQueue.main.async {
            self.categoryColorImage.image = UIImage(color: validColor)
            self.categoryColorImage.layer.cornerRadius = 10.0
            self.categoryColorImage.clipsToBounds = true
            self.categoryColorImage.layer.borderWidth = 0.1
            self.categoryName.text = categoryModel.name
        }
    }
}
