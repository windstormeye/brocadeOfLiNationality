//
//  ShowContentView.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

public class PJShowContentView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView() {
        let imgView: UIImageView = UIImageView(frame: CGRect(x: width / 2, y: 0, width: 5, height: height))
        addSubview(imgView)
        UIGraphicsBeginImageContext(imgView.frame.size) // 位图上下文绘制区域
        imgView.image?.draw(in: imgView.bounds)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setLineCap(CGLineCap.square)
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(3)
        context.setLineDash(phase: 0, lengths: [10,20])
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: height))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        
        let item = PJShowItem(frame:  CGRect(x: 50, y: 300, width: 70, height: 70))
        item.backgroundColor = UIColor.rgb(230, 230, 230)
        addSubview(item)
        
        item.endTop = 0
        item.endBottom = height
        item.endLeft = 0
        item.endRight = width / 2
        
        let middleX = width / 2
        let middleW = middleX - item.right
        let copyX = middleX + middleW
        
        let copyItem = PJShowItem(frame:  CGRect(x: copyX, y: 300, width: 70, height: 70))
        copyItem.backgroundColor = UIColor.rgb(180, 180, 180)
        addSubview(copyItem)
        
        item.panGestureX = { newCenter in
            let middleX = self.width / 2
            let middleW = middleX - newCenter.x
            let copyX = middleX + middleW
            
            copyItem.center = CGPoint(x: copyX, y: newCenter.y)
        }
    }
}
