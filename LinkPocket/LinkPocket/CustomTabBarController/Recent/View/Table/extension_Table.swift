//
//  extension_Table.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPRecentView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LPLinkTableCell", owner: self, options: nil)?.first as! LPLinkTableCell
        let item = tableItems[indexPath.section].urls[indexPath.row]
        cell.modifyCell(img: item.imageName!, url: item.url!, title: item.title!, color: (item.category?.color()!)!, category: item.category!)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.contentView.backgroundColor = UIColor.colorFromRGB(0xFCFCFC)
            headerTitle.textLabel?.frame = R(0, 0, headerTitle.bounds.width, headerTitle.bounds.height)
            headerTitle.textLabel?.textColor = UIColor.colorFromRGB(0x4D4D4D)
            headerTitle.textLabel?.font = UIFont(name: "Roboto-Bold", size: 12)
            headerTitle.textLabel?.textAlignment = .center
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableItems.count != 0 {
            if (tableItems[section].section) == date("YYYY MM dd") {
                return "TODAY"
            } else {
                return tableItems[section].section
            }
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableItems.count != 0 {
            return tableItems[section].urls.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = mLPCategoryTable.cellForRow(at: indexPath) as? LPLinkTableCell else {
            return
        }
        
        print("\(cell.url.text!) 로 이동합니다.")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
}
