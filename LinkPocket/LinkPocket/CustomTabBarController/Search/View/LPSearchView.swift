//
//  LPSearchView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchView: UIView {

    var inSearchMode: Bool = false
    
    @IBOutlet weak var SearchCategoryList: UICollectionView!
    @IBOutlet weak var SearchTable: UITableView!
    @IBOutlet weak var searchStatusLabel: UILabel!
    
    @IBOutlet weak var categoryHeightConstraint: NSLayoutConstraint! // 검색할때 카테고리 컬렉션 없애주려고 쓰는거
    
    var categorys: [LPCategoryModel] = []
    var urls: [LPLinkModel] = []
    var filteredData: [LPSearchModel] = [] // 얘가 리로드되는 데이터
    var recentSearchArray: [String] = [] // Userdefault에 저장되는 데이터 (url)
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        recentSearchReload()
        
        SearchTable.separatorStyle = .none
        SearchCategoryList.register(UINib(nibName: "LPSearchCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    func recentSearchReload(){
        if let RecentSearch = UserDefaults.standard.array(forKey: "RecentSearch") as? [String]{
            self.recentSearchArray = RecentSearch
        }
        
        for i in 0..<recentSearchArray.count {
            for j in 0..<urls.count {
                if urls[j].url == recentSearchArray[i] {
                    let data = LPSearchModel(urls: urls[j])
                    filteredData.append(data)
                }
            }
        }
        
        SearchTable.reloadData()
    }
    
    func emptyReload() {
        filteredData.removeAll()
        SearchTable.reloadData()
    }
    
    // 얘 왜 안되냐
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3, animations: {
            self.tableBottomConstraint.constant = -keyboardHeight
            self.layoutIfNeeded()
            })
        }
    }
   
}

