//
//  ShareConfirmView.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 29..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareConfirmView: UIView {
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var touchView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.confirmLabel.layer.borderColor = UIColor.black.cgColor
        self.confirmLabel.layer.borderWidth = 2
        self.confirmLabel.layer.cornerRadius = 10
        self.confirmLabel.clipsToBounds = true
        
        setGestureRecognizer()
    }
    
    func setGestureRecognizer() {
        let openAppGesture = UITapGestureRecognizer(target: self, action: #selector(self.openApp(tap:)))
        let closeAppGesture = UITapGestureRecognizer(target: self, action: #selector(self.closeApp(tap:)))
        
        touchView.isUserInteractionEnabled = true
        confirmLabel.isUserInteractionEnabled = true

        touchView.addGestureRecognizer(closeAppGesture)
        confirmLabel.addGestureRecognizer(openAppGesture)
    }
    
    @objc func closeApp(tap: UITapGestureRecognizer) {
        ShareExtensionContext.sharedExtension?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    @objc func openApp(tap: UITapGestureRecognizer) {
        ShareExtensionContext.sharedExtension?.completeRequest(returningItems: [], completionHandler: { (bool) in
            guard let url = URL(string: "OpenLinkPocket://") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
    }
}
