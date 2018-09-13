//
//  ShareAddUrlTableViewAdapter.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol ShareAddUrlTableViewAdapterDelegate {
    func cellDidClicked(category: LPCategoryModel)
}

class ShareAddUrlTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    var categoryModelList: [LPCategoryModel] = [LPCategoryModel]()
    let identifier: String = "ShareAddUrlTableViewCell"
    var delegate: ShareAddUrlTableViewAdapterDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ShareAddUrlTableViewCell
        cell.modifyCell(with: categoryModelList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ShareAddUrlTableViewCell
        var category: LPCategoryModel = LPCategoryModel()
        category.name = cell.categoryName.text!
        print("cate name : \(String(describing: category.name))")
        category.setRGBA(color: cell.categoryColor!)
        
        self.delegate?.cellDidClicked(category: category)
    }
}
