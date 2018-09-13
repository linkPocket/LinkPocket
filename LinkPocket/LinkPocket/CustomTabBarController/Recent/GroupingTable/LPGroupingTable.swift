//
//  LPGroupingTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 18..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

func LPGroupingTable(urls: [LPLinkModel]) -> [LPTableSectionModel] {
    var sectionData: [LPTableSectionModel] = []
    
    var dateText: String = date("YYYY MM dd")
    var groupUrls: [LPLinkModel] = []
    
    for i in 0..<urls.count {

        let date = urls[i].date! as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM dd"
        let contentsDate = formatter.string(from: date)

        if dateText == contentsDate {
            groupUrls.append(urls[i])
            if i == (urls.count - 1) {
                let section = LPTableSectionModel(section: dateText, urls: groupUrls)
                sectionData.append(section)
                groupUrls.removeAll()
            }
        } else {
            if groupUrls.count != 0 {
                let section = LPTableSectionModel(section: dateText, urls: groupUrls)
                sectionData.append(section)
                groupUrls.removeAll()
            }
            
            if i == (urls.count - 1) {
                groupUrls.append(urls[i])
                let section = LPTableSectionModel(section: dateText, urls: groupUrls)
                sectionData.append(section)
                groupUrls.removeAll()
            }

           dateText = contentsDate
           groupUrls.append(urls[i])
        }

    }
    
    return sectionData
}
