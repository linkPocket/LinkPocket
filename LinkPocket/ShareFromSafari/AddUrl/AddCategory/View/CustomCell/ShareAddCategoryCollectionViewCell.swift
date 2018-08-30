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
    @IBOutlet weak var colorImage: UIImageView!
    var color: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createColorImage()
        // Initialization code
    }

    func createColorImage() {
        self.colorImage.layer.cornerRadius = 24
        self.colorImage.clipsToBounds = true
        self.colorImage.contentMode = .scaleAspectFit

        self.selectedImageView.layer.cornerRadius = 30
        self.selectedImageView.layer.borderWidth = 2
        self.selectedImageView.layer.borderColor = UIColor.red.cgColor
        self.selectedImageView.isHidden = false
        self.selectedImageView.clipsToBounds = true
        self.selectedImageView.isHidden = true
    }
    
    func modifyCell(color: UIColor) {
        self.color = color
        self.colorImage.image = UIImage(color: color)
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.selectedImageView.isHidden = false
            } else {
                self.selectedImageView.isHidden = true
            }
        }
    }
}
