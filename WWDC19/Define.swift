//
//  Define.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width

func fitWidth(_ width: CGFloat) -> CGFloat {
    return screenWidth / 375.0 * width
}

func fitHeiht(_ height: CGFloat) -> CGFloat {
    return screenHeight / 667.0 * height
}

extension UIColor {
    class func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    class func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    class func bgColor() -> UIColor {
        return rgb(29, 36, 73)
    }
}

extension UIImage {
    /// 通过原图获取 rect 大小的图片
    func image(with rect: CGRect) -> UIImage {
        let scale = UIScreen.main.scale
        let x = rect.origin.x * scale
        let y = rect.origin.y * scale
        let w = rect.size.width * scale
        let h = rect.size.height * scale
        let finalRect = CGRect(x: x, y: y, width: w, height: h)
        
        let originImageRef = self.cgImage
        let finanImageRef = originImageRef!.cropping(to: finalRect)
        let finanImage = UIImage(cgImage: finanImageRef!, scale: scale, orientation: .up)

        return finanImage
    }
    
    
    func drawTextInImage(index: Int) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let att = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)]
    
        let text = NSString(string: "\(index)")
        let size =  text.size(withAttributes: att)
        text.draw(in: CGRect.init(x: size.width + 10, y: 10, width: 20, height: 20),
                  withAttributes: att)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

public func PJInsertRoundingCorners(_ view: UIView) {
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 8.0, height: 8.0))
    let pathMaskLayer = CAShapeLayer()
    pathMaskLayer.frame = view.bounds
    pathMaskLayer.path = path.cgPath
    view.layer.mask = pathMaskLayer
}

