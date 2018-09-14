//
//  ShareImageInfoModel.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import Foundation
import UIKit

struct ShareImageInfoModel {
    var image: UIImage
    var titleText: String
    var url: String
    
    init() {
        image = UIImage()
        titleText = String()
        url = String()
    }
    
    init(image: UIImage, titleText: String, url: String) {
        self.image = image
        self.titleText = titleText
        self.url = url
    }
    
    mutating func setImageAndTitleTextAndUrl(image: UIImage, titleText: String, url: String) {
        self.image = image
        self.titleText = titleText
        self.url = url
    }
}
