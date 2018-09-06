//
//  extension_SearchBar.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredData: [LPSearchModel] = []
        var urls: [LPLinkModel] = []
        var titles: [LPLinkModel] = []
        //var categorys: [LPCategoryModel] = []
        inSearchMode = true
        
        urls = self.urls.filter{($0.url?.localizedCaseInsensitiveContains(searchText))!}
        titles = self.urls.filter{($0.title?.localizedCaseInsensitiveContains(searchText))!}
        //categorys = self.categorys.filter{($0.name?.localizedCaseInsensitiveContains(searchText))!}
        
        for i in 0..<titles.count {
            let data = LPSearchModel(urls: titles[i])
            filteredData.append(data)
        }
        
        for i in 0..<urls.count {
            let data = LPSearchModel(urls: urls[i])
            filteredData.append(data)
        }
        
        self.FilteredReload(filteredData: filteredData)
        
        if searchText == "" {
            mLPSearchView.recentSearchReload()
            mLPSearchView.searchStatusLabel.text = "최근검색"
            categoryCollectionAnimation(height: 77)
        } else {
            mLPSearchView.searchStatusLabel.text = "검색중.."
            categoryCollectionAnimation(height: 0)
        }
    }
    
    
    func searchFeild(searchField: UISearchBar, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mLPSearchView.searchStatusLabel.text = "최근검색"
        categoryCollectionAnimation(height: 77)
        mLPSearchView.recentSearchReload()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            mLPSearchView.recentSearchReload()
        }
    }
    
    func categoryCollectionAnimation(height: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.mLPSearchView.categoryHeightConstraint.constant = height
            self.mLPSearchView.layoutIfNeeded()
        })
    }
}
