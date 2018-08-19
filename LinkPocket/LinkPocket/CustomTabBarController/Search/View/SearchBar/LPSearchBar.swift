//
//  SearchBarTableView.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

protocol SearchBarListener {
    func FilteredReload(filteredData: [LPSearchModel])
}

class LPSearchBar: UIView, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    var listener: SearchBarListener!
    var inSearchMode: Bool = false
    var items: [LPSearchModel] = []
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    
    init(frame: CGRect, urls: [LPLinkModel], categorys: [LPCategoryModel]) {
        super.init(frame: frame)
        self.urls = urls
        self.categorys = categorys
        
        for i in 0..<urls.count {
            let data = LPSearchModel(urls: urls[i])
            self.items.append(data)
        }
        
        for i in 0..<categorys.count {
            let data = LPSearchModel(categorys: categorys[i])
            self.items.append(data)
        }
        
        searchBar = UISearchBar(frame: R(0,0,self.bounds.width,self.bounds.height))
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.searchBarStyle = .minimal
        self.addSubview(searchBar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- searchbar delegate protocol
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

        self.listener?.FilteredReload(filteredData: filteredData)
    }
    
    
    func searchFeild(searchField: UISearchBar, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}
