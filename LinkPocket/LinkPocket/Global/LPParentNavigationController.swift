//
//  LPParentNavigationController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPParentNavigationController: UINavigationController {

    static var sharedInstance: UINavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LINK POCKET"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
