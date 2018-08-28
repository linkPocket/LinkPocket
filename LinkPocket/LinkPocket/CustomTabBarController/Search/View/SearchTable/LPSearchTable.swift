//
//  SearchBarTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 16..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchTable: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var mTable: UITableView!
    var items: [LPSearchModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mTable = UITableView(frame: bounds)
        mTable.register(LPSearchTableCell.self, forCellReuseIdentifier: "Cell")
        addSubview(mTable)
        
        mTable.delegate = self
        mTable.dataSource = self
        
        mTable.reloadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! LPSearchTableCell
        
        for sv in cell.contentView.subviews {
            sv.removeFromSuperview()
        }
        let h = cell.bounds.height
        
//        if (self.items[indexPath.row].categorys != nil) {
//            cell.mSearchTableCellCategory = LPSearchTableCellCategory(frame: R(0,0,W,h), category: self.items[indexPath.row].categorys )
//            cell.contentView.addSubview((cell.mSearchTableCellCategory)!)
//        } else {
//            cell.mSearchTableCellUrls = LPSearchTableCellUrls(frame: R(0,0,W,h), url: self.items[indexPath.row].urls )
//            cell.contentView.addSubview((cell.mSearchTableCellUrls)!)
//        }
//        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52 * r
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("카테고리나 유알엘 있는 곳으로 이동합니다.")
    }
    
    func reloadData(items: [LPSearchModel]){
        self.items = items
        mTable.reloadData()
        
    }
    
}
