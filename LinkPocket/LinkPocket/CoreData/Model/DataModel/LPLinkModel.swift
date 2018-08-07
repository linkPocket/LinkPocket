//
//  LinkModel.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//

import Foundation

struct LPLinkModel {
    var url: String?
    var title: String?
    var imageName: String?
    var date: NSDate?
    var category: LPCategoryModel?
    
    func printLinks() {
        print("url : \(String(describing: url)) title : \(String(describing: title)) image_name: \(String(describing: imageName)) date: \(String(describing: date)) category:")
        category?.printCategory()
    }
}
