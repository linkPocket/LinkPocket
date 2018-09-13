//
//  LPGroupingTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 18..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

func LPGroupingTable(urls: [LPLinkModel]) -> [LPTableSectionModel] {
    
    var returnValue: [LPTableSectionModel] = []
    var sectionData: [String: [LPLinkModel]] = [:]
    
    for i in 0..<urls.count {
        let date = urls[i].date! as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM dd"
        let contentsDate = formatter.string(from: date)

        if sectionData[contentsDate] == nil {
            sectionData[contentsDate] = [LPLinkModel]()
        }
        sectionData[contentsDate]?.append(urls[i])
    }
    
    for (dateText, linkModels) in sectionData {
        returnValue.append(LPTableSectionModel(section: dateText, urls: linkModels))
    }
    return returnValue
}
