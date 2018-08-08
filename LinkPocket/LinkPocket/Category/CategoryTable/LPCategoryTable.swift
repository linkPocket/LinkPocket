//
//  LPCategoryTable.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryTable: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var items: [CategoryModel] = []
    var mTable: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        mTable = UITableView(frame: bounds)
        mTable.register(LPCategoryTableCell.self, forCellReuseIdentifier: "Cell")
        mTable.dataSource = self
        mTable.delegate = self
        addSubview(mTable)
        //mTable.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as? LPCategoryTableCell
        
        for sv in (cell?.contentView.subviews)! {
            sv.removeFromSuperview()
        }
        
        cell?.testLabel = UILabel(frame: R(0,0,(cell?.contentView.bounds.width)!, (cell?.contentView.bounds.height)!))
        cell?.testLabel.text = items[indexPath.row].url
        cell?.textLabel?.textAlignment = .center
        cell?.contentView.addSubview((cell?.testLabel)!)
        
        return cell!
    }
    
    func displayTableContent(categoryN: String, urls: [CategoryModel]) {
        print("여기는 \(categoryN) 카테고리 테이블입니다")
        self.items = urls
        mTable.reloadData()
    }
}
