//
//  ShareSelectNaviController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 21..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareParentNaviController: UINavigationController {
    
    static var rootNaviController: ShareParentNaviController = ShareParentNaviController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShareParentNaviController.rootNaviController.navigationBar.isTranslucent = false
        ShareParentNaviController.rootNaviController.navigationBar.shadowImage = UIImage()
        ShareParentNaviController.rootNaviController.navigationBar.backIndicatorImage = UIImage()
        ShareParentNaviController.rootNaviController.navigationBar.tintColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
