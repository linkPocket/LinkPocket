//
//  extension_EachCategoryTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension EachCategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? LPLinkTableCell
        
        if cell == nil {
            
        } else {
            let item = tableItems[indexPath.section].urls[indexPath.row]
            cell?.modifyCell(img: item.imageName!, url: item.url!, title: item.title!, color: (item.category?.color())!, category: item.category!)
            cell?.selectionStyle = .none
            
        }
        return cell!
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = categoryTable.cellForRow(at: indexPath) as? LPLinkTableCell else {
            return
        }
        
        let url = cell.url.text!
        if statusEdit {
            if editSelectedURL.contains(url) {
                cell.contentView.backgroundColor = UIColor.white
                self.editSelectedURL = self.editSelectedURL.filter {$0 != url}
            } else {
                cell.contentView.backgroundColor = UIColor.colorFromRGB(0xdedede)
                self.editSelectedURL.append(url)
            }
            editCountLabel.text = "\(editSelectedURL.count)"
            print(editSelectedURL)
        } else {
            print("\(url) 로 이동합니다.")
        }
    }
    
    //이거 도데체 어디가 옵셔널일까
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            let item = self.tableItems[indexPath.section].urls[indexPath.row]
            let editVC = LPEditLinkTitleController(nibName: "LPEditLinkTitleController", bundle: nil)
            //editVC.mLPEditLinkTitleView.setBaseData(categoryN: (item.category?.name)!, image: "Naver", title: item.title!, url: item.url!, date: item.date!)
            LPParentNavigationController.sharedInstance.pushViewController(editVC, animated: true)
            
            return
        }
        edit.backgroundColor = UIColor.gray
        return [edit]
    }
    
    func preparingEdit() {
        categoryTable.allowsSelection = true
        UIView.animate(withDuration: 0.1, animations: {
            self.underBarBottom.constant = 0
            self.layoutIfNeeded()
        })
        editCountLabel.isHidden = false
        print("에딧 세팅을 시작합니다.")
    }
    
    func finishEdit() {
        categoryTable.allowsSelection = false
        UIView.animate(withDuration: 0.1, animations: {
            self.underBarBottom.constant = -70
            self.layoutIfNeeded()
        })
        editCountLabel.isHidden = true
        print("에딧 세팅을 끝냅니다.")
        categoryTable.reloadData()
    }
}
