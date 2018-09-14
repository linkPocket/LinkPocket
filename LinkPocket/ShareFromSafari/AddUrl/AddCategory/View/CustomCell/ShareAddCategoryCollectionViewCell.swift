//
//  ShareAddCategoryCollectionViewCell.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareAddCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedImageView: UIImageView!
    var color: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createColorImage()
        // Initialization code
    }

    func createColorImage() {
        self.selectedImageView.layer.cornerRadius = self.selectedImageView.bounds.height/2
        self.selectedImageView.clipsToBounds = true
        self.selectedImageView.contentMode = .scaleAspectFit
    }
    
    func modifyCell(color: UIColor) {
        self.color = color
        self.selectedImageView.backgroundColor = color
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.selectedImageView.image = UIImage(named: "LPCheck")
            } else {
                self.selectedImageView.image = UIImage()
                
            }
        }
    }
}
