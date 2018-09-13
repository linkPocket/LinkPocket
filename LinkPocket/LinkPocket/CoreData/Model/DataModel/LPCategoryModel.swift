//
//  CategoryModel.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//

import Foundation
import UIKit

struct LPCategoryModel {
    var name: String?
    var r: Double?
    var g: Double?
    var b: Double?
    var alpha: Double?
    
    func color() -> UIColor? {
        if let red = r, let green = g, let blue = b, let al = alpha {
            return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(al))
        }
        return nil
    }
    
    mutating func setRGBA(color: UIColor) {
        r = Double(color.redValue)
        g = Double(color.greenValue)
        b = Double(color.blueValue)
        alpha = Double(color.alphaValue)
    }
    
    func printCategory() {
        print("name : \(String(describing: name)) color : \(String(describing: r)), \(String(describing: g)), \(String(describing: b)), \(String(describing: alpha))")
    }
}

extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}
