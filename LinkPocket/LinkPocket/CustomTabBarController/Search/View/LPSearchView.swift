//
//  LPSearchView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol LPSearchViewDelegate {
    func removeAllSearchDataBtnClicked()
}

class LPSearchView: UIView {

    var inSearchMode: Bool = false
    var delegate: LPSearchViewDelegate? = nil
    
    @IBOutlet weak var removeAllOfCurrentSearchContents: UILabel!
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
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
        
        recentSearchReload()
        
        SearchTable.separatorStyle = .none
        SearchCategoryList.register(UINib(nibName: "LPSearchCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeAllBtnClicked))
        removeAllOfCurrentSearchContents.addGestureRecognizer(tap)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: 70, height: 55)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 0
        SearchCategoryList!.collectionViewLayout = layout
    }
    
    @objc func removeAllBtnClicked() {
        self.delegate?.removeAllSearchDataBtnClicked()
    }
    
    func recentSearchReload() {
        self.recentSearchArray = [String]()
        
        if let RecentSearch = UserDefaults.standard.object(forKey: "RecentSearch") as? [String] {
            self.recentSearchArray = RecentSearch
        }
        
        self.removeAllOfCurrentSearchContents.isHidden = self.recentSearchArray.isEmpty ? true : false
        
        filteredData = []
        var removeIndexs: [Int] = []
        for i in 0 ..< recentSearchArray.count {
            var isExist: Bool = false
            
            for j in 0 ..< urls.count {
                if urls[j].url == recentSearchArray[i] {
                    isExist = true
                    let data = LPSearchModel(urls: urls[j])
                    filteredData.append(data)
                }
            }
            
            if isExist == false {
                removeIndexs.append(i)
            }
        }
        
        for i in removeIndexs {
            recentSearchArray.remove(at: i)
        }
        
        if recentSearchArray.isEmpty == false {
            UserDefaults.standard.set(recentSearchArray, forKey: "RecentSearch")
            UserDefaults.standard.synchronize()
        }
        
        SearchTable.reloadData()
    }    
}

