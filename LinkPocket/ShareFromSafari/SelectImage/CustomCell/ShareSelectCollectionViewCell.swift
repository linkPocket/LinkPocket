//
//  ShareSelectCollectionViewCell.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 21..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareSelectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func modifyCell(with image: UIImage) {
        self.imageView.image = image
        self.imageView.backgroundColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1)
        self.imageView.layer.cornerRadius = 8.0
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1).cgColor
    }
    
    func modifyCell(with imageURL: String) {
        self.imageView.image = urlToImage(imageURL: imageURL)
        self.imageView.backgroundColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1)
        self.imageView.layer.cornerRadius = 8.0
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1).cgColor
    }
    
    func urlToImage(imageURL: String) -> UIImage? {
        print("image url : \(imageURL)")
        if let validURL = URL(string: imageURL) {
            if let data = try? Data(contentsOf: validURL)
            {
                if let image: UIImage = UIImage(data: data) {
                    let imageWidth = image.size.width
                    let imageHeight = image.size.height
                    let cellSize = UIScreen.main.bounds.width / 3.5
                    if imageWidth >= cellSize * 0.9 || imageHeight > cellSize * 0.9 {
                        return image
                    }
                }
            }
        }
        return nil
    }
}
