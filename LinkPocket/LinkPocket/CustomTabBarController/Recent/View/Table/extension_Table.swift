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
        let url = cell.url.text!
        
        guard let validUrl = URL(string: url) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(validUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(validUrl)
        }
        print("\(cell.url.text!) 로 이동합니다.")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102.5
    }
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            let item = self.tableItems[indexPath.section].urls[indexPath.row]
            let editVC = LPEditLinkTitleController(nibName: "LPEditLinkTitleController", bundle: nil)
            editVC.setBaseData(categoryN: (item.category?.name!)!, image: item.imageName!, title: item.title!, url: item.url!, date: item.date!)
            LPParentNavigationController.sharedInstance.pushViewController(editVC, animated: true)
            
            return
        }
        edit.backgroundColor = UIColor.gray
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let item = self.tableItems[indexPath.section].urls[indexPath.row]
            self.deleteSelectedURL = item.url!
            
            self.listener?.deleteAlertAction()
            
            return
        }
        delete.backgroundColor = UIColor.red
        return [edit, delete]
    }
    
    func deleteAlertAction() {
        LPCoreDataManager.store.deleteFromLinkWhere(urlIs: deleteSelectedURL)
        reloadTableData()
    }
    
    func reloadTableData() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        tableItems = LPGroupingTable(urls: urls)
        tableItems = tableItems.sorted(by: { $0.section > $1.section })
        
        mLPCategoryTable.reloadData()
    }
    
}
