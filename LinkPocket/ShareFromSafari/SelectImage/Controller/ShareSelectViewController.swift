//
//  ShareSelectViewController.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 21..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class ShareSelectViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var previewImage: UIImage = UIImage()
    var parsingImages: [UIImage] = [UIImage]()
    var parsingTitle: String = String()
    var url: URL?
    
    let identifier: String = "ShareSelectCollectionViewCell"
    let htmlParser: LPHtmlParser = LPHtmlParser()
    let collectionViewAdapter: ShareSelectCollectionViewAdapter = ShareSelectCollectionViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeBtnClicked))

        let nibCell = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: identifier)
        
        collectionView.delegate = collectionViewAdapter
        collectionView.dataSource = collectionViewAdapter
        collectionViewAdapter.delegate = self
        htmlParser.delegate = self
        
        if let validUrl = url {
            self.indicator.startAnimating()
            DispatchQueue.global().async {
                self.htmlParser.startParsing(with: validUrl, parsingType: .LPShareExtension)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "사진 선택"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func closeBtnClicked() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                ShareExtensionContext.sharedExtension?.completeRequest(returningItems: [], completionHandler: nil)
            })
        }
    }
}

extension ShareSelectViewController: LPHtmlParserDelegate {
    func parsingDidFinish(with parsingType: ParsingType, parsingList: [UIImage]) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
        
        switch parsingType {
        case .LPShareExtension:
            self.collectionViewAdapter.parsingImages = parsingList
            self.collectionViewAdapter.parsingImages.insert(previewImage, at: 0)
            self.collectionViewAdapter.parsingImages.insert(UIImage(color: UIColor(red: 200/255, green: 201/255, blue: 203/255, alpha: 1))!, at: 0)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func parsingDidFinish(with parsingType: ParsingType, titleText: String) {
        switch parsingType {
        case .LPShareExtension:
            self.parsingTitle = titleText
        }
    }
}

extension ShareSelectViewController: ShareSelectCollectionViewAdapterDelegate {
    func collectionViewCellDidClicked(image: UIImage) {
        let addUrlVC = ShareAddUrlViewController(nibName: "ShareAddUrlViewController", bundle: nil)
        addUrlVC.imageInfo.setImageAndTitleTextAndUrl(image: image, titleText: self.parsingTitle, url: (url?.relativeString)!)
        ShareParentNaviController.rootNaviController.pushViewController(addUrlVC, animated: true)
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
