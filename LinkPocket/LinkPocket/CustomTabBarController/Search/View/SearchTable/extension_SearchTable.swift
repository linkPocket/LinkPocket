//
//  extension_SearchViewTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPSearchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteredData[indexPath.row]
        let cell = Bundle.main.loadNibNamed("LPLinkTableCell", owner: self, options: nil)?.first as! LPLinkTableCell
        cell.modifyCell(img: item.urls.imageName!, url: item.urls.url!, title: item.urls.title!, color: (item.urls.category?.color()!)!, category: item.urls.category!)
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = SearchTable.cellForRow(at: indexPath) as? LPLinkTableCell else {
            return
        }
        
        if recentSearchArray.count > 20 {
            recentSearchArray.removeLast()
        }
        recentSearchArray.insert(cell.url.text!, at: 0)
        UserDefaults.standard.set(recentSearchArray, forKey: "RecentSearch")
        UserDefaults.standard.synchronize()
        
        let url = cell.url.text!
        guard let validUrl = URL(string: url) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(validUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(validUrl)
        }
        print(" \(url) 로 이동합니다.")
        
        print("카테고리나 유알엘 있는 곳으로 이동합니다.")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102.5
    }
    
    func FilteredReload(filteredData: [LPSearchModel]) {
        self.filteredData = filteredData
        SearchTable.reloadData()
    }
}
