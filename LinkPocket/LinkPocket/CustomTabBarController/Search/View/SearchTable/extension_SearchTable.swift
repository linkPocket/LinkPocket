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
        if (self.filteredData[indexPath.row].categorys != nil) {
            let cell = Bundle.main.loadNibNamed("LPSearchTableCell", owner: self, options: nil)?.first as! LPSearchTableCell
            cell.selectionStyle = .none
            cell.modifyCell(color: item.categorys.color()!, categoryN: item.categorys.name!)
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("LPLinkTableCell", owner: self, options: nil)?.first as! LPLinkTableCell
            cell.modifyCell(img: item.urls.imageName!, url: item.urls.url!, title: item.urls.title!, color: (item.urls.category?.color()!)!, category: item.urls.category!)
            cell.selectionStyle = .none
            return cell
        }
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredData[indexPath.row]
        if item.categorys != nil {
            guard let cell = SearchTable.cellForRow(at: indexPath) as? LPSearchTableCell else {
                return
            }
            let urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
            let categoryUrls = urls.filter { $0.category?.name == cell.label.text! }
            
            let categoryVC = EachCategoryController(nibName: "EachCategoryController", bundle: nil)
            var grouping = LPGroupingTable(urls: categoryUrls)
            grouping = grouping.sorted(by: { $0.section > $1.section })
            categoryVC.displayCategoryPage(categoryName: cell.label.text!, categoryCount: "\(categoryUrls.count)", urls: grouping)
            LPParentNavigationController.sharedInstance.pushViewController(categoryVC, animated: true)

        } else {
            guard let cell = SearchTable.cellForRow(at: indexPath) as? LPLinkTableCell else {
                return
            }
            
            if recentSearchArray.count < 20 {
                recentSearchArray.append( cell.url.text! )
                print("저장됨")
            } else {
                recentSearchArray.remove(at: 19)
                recentSearchArray.append( cell.url.text! )
                print("스무개 넘어서 하나 지우고 저장됨")
            }
            UserDefaults.standard.set(recentSearchArray, forKey: "RecentSearch")

            
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
        
        }
        print("카테고리나 유알엘 있는 곳으로 이동합니다.")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func FilteredReload(filteredData: [LPSearchModel]){
        self.filteredData = filteredData
        SearchTable.reloadData()
    }
}
