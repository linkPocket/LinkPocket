//
//  LPSearchView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPSearchView: UIView {

    @IBOutlet weak var SearchBar: UISearchBar!
    var inSearchMode: Bool = false
    
    @IBOutlet weak var SearchCategoryList: UICollectionView!
    
    @IBOutlet weak var SearchTable: UITableView!
    var filteredData: [LPSearchModel] = []
    
    var categorys: [LPCategoryModel] = []
    var urls: [LPLinkModel] = []
    
    override func awakeFromNib() {
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        
        SearchTable.separatorStyle = .none
        
        SearchCategoryList.register(UINib(nibName: "LPSearchCategoryListCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

    }
    
    var recentSearchArray: [LPSearchModel] = []
}

extension LPSearchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteredData[indexPath.row]
        if (self.filteredData[indexPath.row].categorys != nil) {
            let cell = Bundle.main.loadNibNamed("LPSearchTableCell", owner: self, options: nil)?.first as! LPSearchTableCell
            cell.selectionStyle = .none
            let color: UIColor = UIColor.init(red: CGFloat(item.categorys.r!), green: CGFloat(item.categorys.g!), blue: CGFloat(item.categorys.b!), alpha: CGFloat(item.categorys.alpha!))

            cell.modifyCell(color: color , categoryN: item.categorys.name!)
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("LPLinkTableCell", owner: self, options: nil)?.first as! LPLinkTableCell
            cell.modifyCell(img: item.urls.imageName!, url: item.urls.url!, title: item.urls.title!, category: item.urls.category!)
            cell.selectionStyle = .none
            return cell
        }

        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //UserDefaults.standard.set(recentSearchArray, forKey: "recentSearch")
        print("카테고리나 유알엘 있는 곳으로 이동합니다.")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 52 * r
    }
    
    func FilteredReload(filteredData: [LPSearchModel]){
        self.filteredData = filteredData
        SearchTable.reloadData()
    }
    
    
}


extension LPSearchView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LPSearchCategoryListCell = SearchCategoryList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LPSearchCategoryListCell
        
        let item = categorys[indexPath.row]
        cell.modifyCell(r: item.r!, g: item.g!, b: item.b!, alpha: item.alpha!, categoryN: item.name!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = SearchCategoryList.cellForItem(at: indexPath) as? LPSearchCategoryListCell else {
            return
        }
        
        for i in 0..<SearchCategoryList.subviews.count - 2 {
            if i == indexPath.row {
                (SearchCategoryList.subviews[indexPath.row] as! LPColorCell).onClicked()
            } else {
                (SearchCategoryList.subviews[i] as! LPColorCell).onUnclicked()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 55)
    }
    
}

extension LPSearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredData: [LPSearchModel] = []
        var urls: [LPLinkModel] = []
        var categorys: [LPCategoryModel] = []
        inSearchMode = true
        
        urls = self.urls.filter{($0.url?.localizedCaseInsensitiveContains(searchText))!}
        categorys = self.categorys.filter{($0.name?.localizedCaseInsensitiveContains(searchText))!}
        
        for i in 0..<categorys.count {
            let data = LPSearchModel(categorys: categorys[i])
            filteredData.append(data)
        }
        
        for i in 0..<urls.count {
            let data = LPSearchModel(urls: urls[i])
            filteredData.append(data)
        }
        
        self.FilteredReload(filteredData: filteredData)
        print("몇갤까 \(filteredData.count)")
    }
    
    
    func searchFeild(searchField: UISearchBar, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}



