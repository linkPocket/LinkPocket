//
//  LPAddViewController.swift
//  LinkPocket
//
//  Created by user on 2018. 11. 13..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import Lottie

class LPAddViewController: UIViewController {
    
    var imageInfo: ShareImageInfoModel = ShareImageInfoModel()
    
    var titleText: String = String()
    var addUrlView: ShareAddUrlView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let customView = Bundle.main.loadNibNamed("ShareAddUrlView", owner: self, options: nil)?.first as? ShareAddUrlView else {
            return
        }
        
        addUrlView = customView
        addUrlView?.imageView.image = self.imageInfo.image
        addUrlView?.titleTextView.text = self.imageInfo.titleText
        addUrlView?.delegate = self
        addUrlView?.tableViewAdapter?.delegate = self
        getCategoryList()
        self.view.addSubview(addUrlView!)
        
        let tapTerm:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTextView))
        self.addUrlView?.titleTextView.addGestureRecognizer(tapTerm)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addUrlView?.titleTextView.text = imageInfo.titleText
        self.title = "추가 하기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    @objc func tapTextView() {
        let editTitleVC: ShareEditTitleViewController = ShareEditTitleViewController(nibName: "ShareEditTitleViewController", bundle: nil, imageInfo: self.imageInfo)
        editTitleVC.delegate = self
        LPParentNavigationController.sharedInstance.pushViewController(editTitleVC, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getCategoryList() {
        DispatchQueue.main.async {
            self.addUrlView?.tableViewAdapter?.categoryModelList = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
            self.addUrlView?.tableView.reloadData()
        }
    }
}

extension LPAddViewController: ShareEditTitleViewControllerDelegate {
    func finishEdit(text: String) {
        DispatchQueue.main.async {
            self.imageInfo.titleText = text
        }
    }
}

extension LPAddViewController: ShareAddUrlViewDelegate {
    func floatingBtnClicked() {
        let addCategoryVC = LPAddCategoryViewController(nibName: "LPAddCategoryViewController", bundle: nil)
        addCategoryVC.imageInfo = self.imageInfo
        LPParentNavigationController.sharedInstance.pushViewController(addCategoryVC, animated: true)
    }
}

extension LPAddViewController: ShareAddUrlTableViewAdapterDelegate {
    
    func cellDidClicked(category: LPCategoryModel) {
        let imageNumber = UserDefaults.standard.integer(forKey: "imageNumber")
        
        let appendingPathComponent = "\(imageNumber).png"
        
        UserDefaults.standard.set(imageNumber + 1, forKey: "imageNumber")
        UserDefaults.standard.synchronize()
        
        let link: LPLinkModel = LPLinkModel(url: self.imageInfo.url, title: self.imageInfo.titleText, imageName: writeFile(appendingPathComponent)?.relativeString, date: Date() as NSDate, category: category)
        
        guard LPCoreDataManager.store.insertIntoLink(valueLink: link) else {
            createLinkFailed()
            return
        }

        let urlString = "OpenLinkPocket://\(category.name!)"
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let validString = escapedString {
            guard let url = URL(string: validString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func createLinkFailed() {
        let alertController = UIAlertController(title: "링크를 만들 수 없습니다", message: "링크가 있는지 확인해보세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func writeFile(_ appendingPathComponent: String) -> URL? {
        var photoURL: URL? = nil
        if let data = UIImagePNGRepresentation(self.imageInfo.image) {
            photoURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.CoreDataTest2")?.appendingPathComponent(appendingPathComponent)
            do {
                try data.write(to: photoURL!, options: .atomic)
            } catch {
                print("\(#file)#\(#function)(\(#line)): error: \(error.localizedDescription)")
            }
        }
        return photoURL
    }
}
