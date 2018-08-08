//
//  CategoryModel.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//

import Foundation

struct LPCategoryModel {
    var name: String?
    var r: Double?
    var g: Double?
    var b: Double?
    var alpha: Double?
    
    func printCategory() {
        print("name : \(String(describing: name)) color : \(String(describing: r)), \(String(describing: g)), \(String(describing: b)), \(String(describing: alpha))")
    }
}
