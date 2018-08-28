//
//  LPRequireMethod.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

import UIKit

let W = UIScreen.main.bounds.width
let H = UIScreen.main.bounds.height
let statusH = UIApplication.shared.statusBarFrame.height
let r = W/375
let wColor = UIColor.colorFromRGB(0xefefef)

open class View : UIView {
    
    public var enabled:Bool = true
    public var highlightEnabled:Bool = true
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public var onTouch:((Bool)->())?
    public var onClick:(()->())?
    
    private var _valid:Bool = false
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if enabled {
            onTouch?(true)
            _valid = true
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if enabled {
            onTouch?(false)
            if _valid { onClick?() }
        }
    }
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if enabled {
            onTouch?(false)
        }
    }
    
}

public class ImageView: View {
    
    var image: UIImageView!
    
    init(frame: CGRect, named: String ) {
        super.init(frame: frame)
        
        image = UIImageView(frame: bounds)
        image.image = UIImage(named: named)
        image.isUserInteractionEnabled = false
        addSubview(image)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public class Label: View {
    
    var label: UILabel!
    
    
    init(frame: CGRect, content: String) {
        super.init(frame: frame)
        
        label = UILabel(frame: bounds)
        label.text = content
        label.isUserInteractionEnabled = false
        addSubview(label)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIColor {
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

let blue = UIColor.colorFromRGB(0x008eff)
let purple = UIColor.colorFromRGB(0x9013FE)
let red = UIColor.colorFromRGB(0xF70000)
let yellow = UIColor.colorFromRGB(0xF8E71C)
let green = UIColor.colorFromRGB(0x10E10E)

public func R(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

public func rR(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x*r, y: y*r, width: width*r, height: height*r)
}

public func date(_ formatter: String) -> String {
    let updateDate = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY MM dd"
    let dateString = formatter.string(from: updateDate)
    
    return dateString
}

extension UIView {
    func Shadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius //얘가 블러역할
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}



