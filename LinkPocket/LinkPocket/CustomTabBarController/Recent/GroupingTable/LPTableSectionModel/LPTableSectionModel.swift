//
//  LPTableSectionModel.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 18..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPTableSectionModel {
    var section: String!
    var urls: [LPLinkModel] = []
    
    init(section: String, urls: [LPLinkModel]) {
        self.section = section
        self.urls = urls
    }
}
