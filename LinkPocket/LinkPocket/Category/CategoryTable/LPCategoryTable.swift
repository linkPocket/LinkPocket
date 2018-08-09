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
    var mTable: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        mTable = UITableView(frame: bounds)
        mTable.register(LPCategoryTableCell.self, forCellReuseIdentifier: "Cell")
        mTable.dataSource = self
        mTable.delegate = self
        addSubview(mTable)
        mTable.separatorStyle = .none
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
        
        let item = items[indexPath.row]
        
        cell?.urlL = UILabel(frame: rR(37,5,150, 12))
        cell?.urlL.text = items[indexPath.row].url
        cell?.urlL.font = UIFont(name: "Roboto-Medium", size: 10*r)
        cell?.contentView.addSubview((cell?.urlL)!)
        cell?.urlL.sizeToFit()
        
        let categoryX = (37*r) + (cell?.urlL.bounds.width)! + (15*r)
        
        cell?.categoryL = UILabel(frame: rR( categoryX, 5, 57, 12))
        cell?.categoryL.text = items[indexPath.row].category?.name
        cell?.categoryL.textAlignment = .center
        cell?.categoryL.textColor = UIColor.white
        cell?.categoryL.font = UIFont(name: "Roboto-Medium", size: 10*r)
        cell?.contentView.addSubview((cell?.categoryL)!)
        cell?.categoryL.layer.masksToBounds = true
        cell?.categoryL.layer.cornerRadius = 6.5*r
        
        cell?.categoryL.backgroundColor = UIColor.init(red: CGFloat(item.category!.r!), green: CGFloat(item.category!.g!), blue: CGFloat(item.category!.b!), alpha: CGFloat((item.category?.alpha)!))
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*r
    }
    
    func displayTableContent(categoryN: String, urls: [LPLinkModel]) {
        print("여기는 \(categoryN) 카테고리 테이블입니다")
        self.items = urls
        mTable.reloadData()
    }
}

let blue = UIColor.colorFromRGB(0x008eff)
let purple = UIColor.colorFromRGB(0x9013FE)
let red = UIColor.colorFromRGB(0xF70000)
let yellow = UIColor.colorFromRGB(0xF8E71C)
