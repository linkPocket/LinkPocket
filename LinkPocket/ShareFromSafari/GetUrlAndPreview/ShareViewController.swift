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
        
        ShareExtensionContext.sharedExtension = self.extensionContext
        setTitleLabel()
    }

    func setTitleLabel() {
        let selectVC = ShareSelectViewController(nibName: "ShareSelectViewController", bundle: nil)
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments as? [NSItemProvider] {
//                for attachment: NSItemProvider in attachments {
                if let attachment = attachments.first {
                    if attachment.hasItemConformingToTypeIdentifier("public.url") {
                        attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                            if let shareURL = url as? NSURL {
                                print("\(String(describing: shareURL.relativeString))")
                                selectVC.url = shareURL as URL
                            }
                        })
                    } else {
                        getUrlFailed()
                    }
                    
                    attachment.loadPreviewImage(options: nil) { (item, error) in
                        if let image = item as? UIImage {
                            DispatchQueue.main.async {
//                                self.preViewImage.image = image
//                                self.preViewImage.contentMode = .scaleAspectFit
                                selectVC.previewImage = image
                                ShareParentNaviController.rootNaviController.pushViewController(selectVC, animated: false)
                                self.present(ShareParentNaviController.rootNaviController, animated: true, completion: nil)
                            }

//                            if let data = UIImagePNGRepresentation(image) {
//                                self.photoURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.CoreDataTest2")?.appendingPathComponent("NAVER.png")
//                                do {
//                                    try data.write(to: self.photoURL!, options: .atomic)
//                                } catch {
//                                    print("\(#file)#\(#function)(\(#line)): error: \(error.localizedDescription)")
//                                }
//                            }
                        }
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
    
//    @IBAction func closeBtnClicked(_ sender: UIButton) {
//        let categoryModel: LPCategoryModel? = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: self.category1.text!)
//        let linkModel: LPLinkModel = LPLinkModel(url: self.titleLabel.text, title: self.contentTextView.text,
//                                                 imageName: String(describing: self.photoURL!), date: Date() as NSDate, category: categoryModel)
//
//        LPCoreDataManager.store.insertIntoLink(valueLink: linkModel)
//
//        DispatchQueue.main.async {
//            self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//        }
//    }
    
//    override func isContentValid() -> Bool {
//
//        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
//            if let attachments = item.attachments as? [NSItemProvider] {
//                for attachment: NSItemProvider in attachments {
//                    attachment.loadPreviewImage(options: nil) { (item, error) in
//                        if let image = item as? UIImage {
////                            if let data = UIImagePNGRepresentation(image) {
////
////                            }
//                        }
//                    }
//
////                    print("attachment : \(attachment)")
//                    if attachment.hasItemConformingToTypeIdentifier("public.url") {
//                        attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
//                            if let shareURL = url as? NSURL {
//                                print("\(String(describing: shareURL.relativeString))")
//                                // Do stuff with your URL now.
//                            }
////                            self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
//                        })
//                    }
//                }
//            }
//        }
//
//
//
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }
}
