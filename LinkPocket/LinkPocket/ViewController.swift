//
//  ViewController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 7. 24..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pasteboard = UIPasteboard.general
        if let string = pasteboard.string {
            print(string)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

