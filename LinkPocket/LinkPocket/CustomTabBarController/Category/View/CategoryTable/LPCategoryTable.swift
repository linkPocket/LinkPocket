//
//  LPCategoryTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryTable: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var items: [LPLinkModel] = []
    var sections: [LPTableSectionModel] = []
    var mTable: UITableView!
    
    init(frame: CGRect, urls: [LPLinkModel]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        mTable = UITableView(frame: bounds)
        mTable.register(LPCategoryTableCell.self, forCellReuseIdentifier: "Cell")
        mTable.dataSource = self
        mTable.delegate = self
        addSubview(mTable)
        mTable.separatorStyle = .none
        
        items = urls
        sections = LPGroupingTable(urls: items)
        
        mTable.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as? LPCategoryTableCell
        
        for sv in (cell?.contentView.subviews)! {
            sv.removeFromSuperview()
        }
        
        let item = sections[indexPath.section].urls[indexPath.row]
        
        cell?.urlL = UILabel(frame: rR(37, 14, 150, 12))
        cell?.urlL.text = item.url
        cell?.urlL.font = UIFont(name: "Roboto-Medium", size: 10 * r)
        cell?.contentView.addSubview((cell?.urlL)!)
        cell?.urlL.sizeToFit()
        
        let categoryX = (37*r) + (cell?.urlL.bounds.width)! + (15 * r)
        
        cell?.categoryL = UILabel(frame: rR( categoryX, 14, 57, 12))
        cell?.categoryL.text = item.category?.name
        cell?.categoryL.textAlignment = .center
        cell?.categoryL.textColor = UIColor.white
        cell?.categoryL.font = UIFont(name: "Roboto-Medium", size: 10 * r)
        cell?.contentView.addSubview((cell?.categoryL)!)
        cell?.categoryL.backgroundColor = UIColor.red //init(red: CGFloat((item.category?.r!)!), green: CGFloat((item.category?.g!)!), blue: CGFloat((item.category?.b!)!), alpha: 1.0)
        cell?.categoryL.layer.masksToBounds = true
        cell?.categoryL.layer.cornerRadius = 6.5 * r
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.contentView.backgroundColor = UIColor.colorFromRGB(0xFCFCFC)
            headerTitle.textLabel?.frame = R(0, 0, headerTitle.bounds.width, headerTitle.bounds.height)
            headerTitle.textLabel?.textColor = UIColor.colorFromRGB(0x4D4D4D)
            headerTitle.textLabel?.font = UIFont(name: "Roboto-Bold", size: 12*r)
            headerTitle.textLabel?.textAlignment = .center
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sections.count != 0 {
        if (sections[section].section) == date("YYYY MM dd") {
            return "TODAY"
        } else {
            return sections[section].section
        }
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections.count != 0 {
        return sections[section].urls.count
            
        } else {
            return 0
            
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40 * r
    }
    
    func displayTableContent(categoryN: String, urls: [LPLinkModel]) {
        print("여기는 \(categoryN) 카테고리 테이블입니다")
        self.items = urls
        sections = LPGroupingTable(urls: items)
        mTable.reloadData()
    }
}
