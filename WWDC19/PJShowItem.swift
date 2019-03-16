//
//  PJShowItem.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit


public class PJShowItem: UIView {
    /// return new item.center
    var panGestureX: ((CGPoint) -> Void)?

    var endXs: [CGFloat]?
    var endYs: [CGFloat]?
    
    var endTop: CGFloat?
    var endBottom: CGFloat?
    var endLeft: CGFloat?
    var endRight: CGFloat?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView() {
        let panGesture = UIPanGestureRecognizer(target: self, action: .pan)
        addGestureRecognizer(panGesture)
    }
    
    @objc
    fileprivate func panGestrue(panGesture: UIPanGestureRecognizer) {
        if (panGesture.state == .changed || panGesture.state == .ended) {
            let translation = panGesture.translation(in: superview)
            
            let final_centerX = center.x + translation.x
            let final_centerY = center.y + translation.y
            
            let final_right = final_centerX + width / 2
            let final_left = final_centerX - width / 2
            
            let final_top = final_centerY - height / 2
            let final_bottom = final_centerY + height / 2
            
            if endLeft != nil {
                if final_left < endLeft! {
                    left = endLeft!
                }
            }
            
            if endRight != nil {
                if final_right > endRight! {
                    right = endRight!
                }
            }
            
            if endTop != nil {
                if final_top < endTop! {
                    top = endTop!
                }
            }
            
            if endBottom != nil {
                if final_bottom > endBottom! {
                    bottom = endBottom!
                }
            }
            
            
            center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            panGesture.setTranslation(.zero, in: superview)
            
            panGestureX?(center)
        }
    }
}


fileprivate extension Selector {
    static let pan = #selector(PJShowItem.panGestrue(panGesture:))
}
