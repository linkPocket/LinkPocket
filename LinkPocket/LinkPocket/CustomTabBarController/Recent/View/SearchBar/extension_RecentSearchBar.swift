//
//  extension_SearchBar.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

extension LPRecentView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchFeild(searchField: UISearchBar, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("검색 시작합니당.")
        mSearchBar.endEditing(true)
        
        let searchVC = LPSearchController(nibName: "LPSearchController", bundle: nil)
        searchVC.tabBarController?.navigationItem.title = ""
        LPParentNavigationController.sharedInstance.pushViewController(searchVC, animated: false)
        
    }
    
}
