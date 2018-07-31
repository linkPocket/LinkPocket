//
//  LPCategoryViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 7. 31..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let pasteboard = UIPasteboard.general
        if let string = pasteboard.string {
            if string.isValidURL {
                print("\(string) is url")
            } else {
                print("\(string) is not url")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
