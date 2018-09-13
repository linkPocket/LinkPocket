//
//  LPHtmlParser.swift
//  ShareFromSafari
//
//  Created by user on 2018. 8. 21..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import Kanna
import SwiftSoup

enum ParsingType {
    case PTShareExtension
    case PTError
}

protocol LPHtmlParserDelegate {
    func parsingDidFinish(with parsingType: ParsingType, parsingList: [UIImage])
    func parsingDidFinish(with parsingType: ParsingType, titleText: String)
}

extension LPHtmlParserDelegate {
    func parsingDidFinish(with parsingType: ParsingType, parsingList: [UIImage]) {}
    func parsingDidFinish(with parsingType: ParsingType, titleText: String) {}
}

class LPHtmlParser: NSObject {
    var delegate: LPHtmlParserDelegate?
    
    func startParsing(with url: URL, parsingType: ParsingType) {
        var myHTMLString: String? = nil
        do {
            myHTMLString = try String(contentsOf: url, encoding: .utf8)
        }  catch let error {
            switch parsingType {
            case .PTShareExtension:
                self.delegate?.parsingDidFinish(with: .PTError, parsingList: [UIImage]())
            default:
                print("")
            }
            print("Error: \(error)")
            return
        }
        
        switch parsingType {
        case .PTShareExtension:
            getTitleAndImageSrcs(use: myHTMLString!, parsingType: .PTShareExtension)
        default:
            print("")
        }
        
    }
    
    func getTitle(use htmlString: String, parsingType: ParsingType) {

        do {
            let doc: Document = try SwiftSoup.parse(htmlString)
            let titleText = try doc.title()
            self.delegate?.parsingDidFinish(with: parsingType, titleText: titleText)
        } catch Exception.Error( _, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    func getTitleAndImageSrcs(use htmlString: String, parsingType: ParsingType) {
        var parsingImages: [UIImage] = [UIImage]()
        let deadlineTime = DispatchTime.now() + .seconds(2)
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.delegate?.parsingDidFinish(with: parsingType, parsingList: parsingImages)
        }

        do {
            let doc: Document = try SwiftSoup.parse(htmlString)
            let pngs: Elements = try doc.select("img[src]")
            let metas: Elements = try doc.select("meta[content]")
            let links: Elements = try doc.select("link[href]")

            self.delegate?.parsingDidFinish(with: parsingType, titleText: try doc.title())
            
            let linksUrls: [String?] = links.array().map { try? $0.attr("href").description }
            var tempUrls: [String] = [String]()
            for link in linksUrls {
                
                if let validSrc = link, let parsingImage = urlToImage(imageURL: validSrc) {
                    if isExistImage(totalImages: tempUrls, findImage: validSrc) == false {
                        parsingImages.append(parsingImage)
                        tempUrls.append(validSrc)
                        self.delegate?.parsingDidFinish(with: parsingType, parsingList: parsingImages)
                    }
                }
            }
            
            let metaUrls: [String?] = metas.array().map { try? $0.attr("content").description }
            for meta in metaUrls {
                if let validSrc = meta, let parsingImage = urlToImage(imageURL: validSrc) {
                    if isExistImage(totalImages: tempUrls, findImage: validSrc) == false {
                        parsingImages.append(parsingImage)
                        tempUrls.append(validSrc)
                        self.delegate?.parsingDidFinish(with: parsingType, parsingList: parsingImages)
                    }
                }
            }
            
            let pngUrls: [String?] = pngs.array().map { try? $0.attr("src").description }
            for png in pngUrls {
                if let validSrc = png, let parsingImage = urlToImage(imageURL: validSrc) {
                    if isExistImage(totalImages: tempUrls, findImage: validSrc) == false {
                        parsingImages.append(parsingImage)
                        tempUrls.append(validSrc)
                        self.delegate?.parsingDidFinish(with: parsingType, parsingList: parsingImages)
                    }
                }
            }
        

        } catch Exception.Error( _, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    func isExistImage(totalImages: [String], findImage: String) -> Bool{
        for image in totalImages {
            if image == findImage {
                return true
            }
        }
        return false
    }
    
    func urlToImage(imageURL: String) -> UIImage? {
        print("image url : \(imageURL)")
        if let validURL = URL(string: imageURL) {
            if let data = try? Data(contentsOf: validURL)
            {
                if let image: UIImage = UIImage(data: data) {
                    let imageWidth = image.size.width
                    let imageHeight = image.size.height
                    let cellSize = UIScreen.main.bounds.width / 3.5
                    if imageWidth >= cellSize * 0.9 || imageHeight > cellSize * 0.9 {
                        return image
                    }
                }
            }
        }
        return nil
    }
}
