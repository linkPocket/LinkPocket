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

class ShareViewController: UIViewController { //SLComposeServiceViewController { UIViewController
    
    @IBOutlet weak var preViewImage: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var category1: UILabel!
    @IBOutlet weak var category2: UILabel!
    @IBOutlet weak var category3: UILabel!
    @IBOutlet weak var category4: UILabel!
    
    var photoURL: URL?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .red
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let testVC = Test2ViewController(nibName: "Test2ViewController", bundle: nil)
//        self.present(testVC, animated: true, completion: nil)
        self.view.backgroundColor = .white
        
        let store = LPCoreDataManager.store
        let results = store.selectAllObjectFromCategory() as? [LPCategoryModel]

        category1.text = results?[0].name
        category2.text = results?[1].name
        category3.text = results?[2].name
        category4.text = results?[3].name
        if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
            // move your content validation to `func isContentValid() -> Bool`

            let attributedString = content.attributedContentText // yay NSAttributedString!
            DispatchQueue.main.async {
                self.contentTextView.attributedText = attributedString
            }
        }
        setTitleLabel()
    }

    func setTitleLabel() {
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachments = item.attachments as? [NSItemProvider] {
                for attachment: NSItemProvider in attachments {
                    if attachment.hasItemConformingToTypeIdentifier("public.url") {
                        attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                            if let shareURL = url as? NSURL {
                                print("\(String(describing: shareURL.relativeString))")
                                DispatchQueue.main.async {
                                    self.titleLabel.text = shareURL.relativeString
                                }
                            }
                        })
                    }
                    
                    attachment.loadPreviewImage(options: nil) { (item, error) in
                        if let image = item as? UIImage {
                            DispatchQueue.main.async {
                                self.preViewImage.image = image
                                self.preViewImage.contentMode = .scaleAspectFit
                            }

                            if let data = UIImagePNGRepresentation(image) {
                                self.photoURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.CoreDataTest2")?.appendingPathComponent("NAVER")
                                do {
                                    try data.write(to: self.photoURL!, options: .atomic)
                                } catch {
                                    print("\(#file)#\(#function)(\(#line)): error: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        let categoryModel: LPCategoryModel? = LPCoreDataManager.store.selectObjectFromCategoryWhere(nameIs: self.category1.text!)
        let linkModel: LPLinkModel = LPLinkModel(url: self.titleLabel.text, title: self.contentTextView.text,
                                                 imageName: String(describing: self.photoURL!), date: Date() as NSDate, category: categoryModel)
        
        LPCoreDataManager.store.insertIntoLink(valueLink: linkModel)
        
//        let defaults = UserDefaults(suiteName: "group.CoreDataTest2")
//        let resultDic: [String: String] =
//            ["url": self.titleLabel.text!, "title": self.contentTextView.text!,
//             "date": String(describing: Date()), "category": category1.text!,
//             "imageName": String(describing: self.photoURL!)]
//
//        if var resultArr = defaults?.object(forKey: "link") as? [[String: String]] {
//            resultArr.append(resultDic)
//            defaults?.set(resultArr, forKey: "link")
//        } else {
//            defaults?.set([resultDic], forKey: "link")
//        }
//        defaults?.synchronize()

        DispatchQueue.main.async {
            self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        }
    }
    
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
