//
//  LPSearchData.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 18..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchModel {
    
    var urls: LPLinkModel!
    var categorys: LPCategoryModel!
    
    init(urls: LPLinkModel) {
        self.urls = urls
    }
    
    init(categorys: LPCategoryModel) {
        self.categorys = categorys
    }
    
}
