//
//  LinkModel.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//

import Foundation

struct LinkModel {
    var url: String?
    var title: String?
    var image_name: String?
    var date: NSDate?
    var category: CategoryModel?
    
    func printLinks() {
        print("url : \(String(describing: url)) title : \(String(describing: title)) image_name: \(String(describing: image_name)) date: \(String(describing: date)) category:")
        category?.printCategory()
    }
}
