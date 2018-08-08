//
//  LPTestModel.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class CategoryModel {
    
    var name: String!
    var url: String!
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
}


/// 수연 테스트 입니다
let b1 = CategoryModel(name: "책", url: "www.book1")
let b2 = CategoryModel(name: "책", url: "www.book2")
let b3 = CategoryModel(name: "책", url: "www.book3")
let b4 = CategoryModel(name: "책", url: "www.book4")
let b5 = CategoryModel(name: "책", url: "www.book5")
let b6 = CategoryModel(name: "책", url: "www.book6")

let f1 = CategoryModel(name: "과일", url: "www.apple")
let f2 = CategoryModel(name: "과일", url: "www.peach")
let f3 = CategoryModel(name: "과일", url: "www.watermelon")
let f4 = CategoryModel(name: "과일", url: "www.guul")

let a1 = CategoryModel(name: "동물", url: "www.dog")
let a2 = CategoryModel(name: "동물", url: "www.cat")
let a3 = CategoryModel(name: "동물", url: "www.rabbit")
let a4 = CategoryModel(name: "동물", url: "www.lion")
let a5 = CategoryModel(name: "동물", url: "www.bear")
let a6 = CategoryModel(name: "동물", url: "www.bird")

let al1 = CategoryModel(name: "알파벳", url: "www.a")
let al2 = CategoryModel(name: "알파벳", url: "www.b")
let al3 = CategoryModel(name: "알파벳", url: "www.c")
let al4 = CategoryModel(name: "알파벳", url: "www.d")
let al5 = CategoryModel(name: "알파벳", url: "www.e")
let al6 = CategoryModel(name: "알파벳", url: "www.f")
let al7 = CategoryModel(name: "알파벳", url: "www.g")
let al8 = CategoryModel(name: "알파벳", url: "www.h")

let testCategorys: [String] = ["책", "과일", "동물", "알파벳"]
var testUrls: [CategoryModel] = [b1, b2, b3, b4, b5, b6,
                                 f1, f2, f3, f4,
                                 a1, a2, a3, a4, a5, a6,
                                 al1, al2, al3, al4, al5, al6, al7, al8,]

