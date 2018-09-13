//
//  ShareViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 7. 26..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import Social
import CoreData
import MobileCoreServices

class ShareViewController: UIViewController {
    
    var photoURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
//        for category in categorys {
//            LPCoreDataManager.store.deleteFromCategoryWhere(nameIs: category.name!)
//        }
//
//        UserDefaults.standard.removeObject(forKey: "imageNumber")
//        UserDefaults.standard.synchronize()
        
        ShareExtensionContext.sharedExtension = self.extensionContext
        setTitleLabel()
    }

    func setTitleLabel() {
        let selectVC = ShareSelectViewController(nibName: "ShareSelectViewController", bundle: nil)
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments as? [NSItemProvider] {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.url") {
                        attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                            if let shareURL = url as? NSURL {
//                                if shareURL.relativeString.validateUrl() {
                                    print("\(String(describing: shareURL.relativeString))")
                                    selectVC.url = shareURL as URL
//                                } else {
//                                    self.getUrlFailed()
//                                }
                                
                                attachment.loadPreviewImage(options: nil) { (item, error) in
                                    if let image = item as? UIImage {
                                        DispatchQueue.main.async {
                                            selectVC.previewImage = image
                                            ShareParentNaviController.rootNaviController.pushViewController(selectVC, animated: false)
                                            self.present(ShareParentNaviController.rootNaviController, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        })
                    } else {
                        getUrlFailed()
                    }
                }
            }
        }
    }
    
    func getUrlFailed() {
        let alertController = UIAlertController(title: "주소를 찾을 수 없습니다.", message: "웹 애플리케이션인지 확인해주세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel) { (action) in
            ShareExtensionContext.sharedExtension?.completeRequest(returningItems: [], completionHandler: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension String {
    func validateUrl () -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
}
