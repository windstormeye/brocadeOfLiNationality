//
//  ViewController.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

public class PJHomeViewController: UIViewController {
    
    var gameType: GameType = .guide
    var brocadeType: BrocadeType = .normal
    var sizeType: SizeType = .rectangle
    var brocadeBackgroundColor: UIColor = UIColor.bgColor()
    
    private var bottomView: PJShowBottonView?
    private var itemTag = 101
    
    public override func loadView() {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.backgroundColor = brocadeBackgroundColor
        
        let contentView = PJShowContentView()
        view.addSubview(contentView)
        contentView.winComplate = {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomView!.top = screenHeight
            })
        }
        
        switch brocadeType {
        case .normal: contentView.itemXCount = 3
        case .small: contentView.itemXCount = 2
        case .big: contentView.itemXCount = 4
        }
        
        switch sizeType {
        case .rectangle: contentView.frame = CGRect(x: 0, y: 0,
                                                    width: view.width,
                                                    height: view.height - 64)
        case .square: contentView.frame = CGRect(x: 0, y: 0,
                                                 width: view.width,
                                                 height: view.width)
            contentView.y = (screenHeight - screenWidth) / 2
        case .circular: break
        }
        
        PJShowItemCreator.shared.brocadeType = brocadeType
        
        let bottomView = PJShowBottonView(height: 64, longPressView: view)
        view.addSubview(bottomView)
        self.bottomView = bottomView
        var imgs = [UIImage]()
        for itemY in 0..<contentView.itemYCont! {
            for itemX in 0..<contentView.itemXCount! {
                let x = (contentView.itemW ?? 0) * CGFloat(itemX)
                let y = (contentView.itemW ?? 0) * CGFloat(itemY)
                var itemW = contentView.itemW
                var itemH = itemW
                
                if itemY == contentView.itemYCont! - 1 {
                    itemW = contentView.itemW
                    itemH = CGFloat(20)
                }
                
                if itemX == contentView.itemXCount! - 1 {
                    itemW = contentView.itemW! / 3 * 2 + 2
                }
                
                let img = contentView.bgImageView?.image?.image(with: CGRect(x: x, y: y,
                                                                             width: itemW!,
                                                                             height: itemH!))
                imgs.append(img!)
            }
        }
        bottomView.viewModel = imgs
        bottomView.moveCell = { cellIndex, centerPoint in
            guard let tempItem = contentView.tempItem else { return }
            tempItem.center = CGPoint(x: centerPoint.x,
                                      y: centerPoint.y + bottomView.top)
        }
        bottomView.moveBegin = { cellIndex in
            guard contentView.itemXCount != nil else { return }
            
            let itemW = contentView.itemW
            // 刚开始的初始化先让其消失
            let moveItem = PJShowItem(frame: CGRect(x: -1000, y: -1000,
                                                    width: itemW!, height: itemW!))
            moveItem.endTop = contentView.endTop
            moveItem.endBottom = contentView.endBottom
            if self.sizeType == .rectangle {
                moveItem.endBottom = screenHeight - 40
            }
            moveItem.endLeft = contentView.endLeft
            moveItem.endRight = contentView.endRight
            moveItem.bgImage = bottomView.viewModel![cellIndex]
            moveItem.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            moveItem.tag = self.itemTag
            self.itemTag += 1
            
            // 最后一排，顺序不能错，从左到右一个一个来！！！
            if [28, 29, 30].contains(moveItem.tag - 100) {
                moveItem.isBottomItem = true
            }
            
            contentView.addSubview(moveItem)
            contentView.tempItem = moveItem
        }
        
        bottomView.moveEnd = {
            guard let tempItem = contentView.tempItem else { return }
            tempItem.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

extension PJHomeViewController {
    public enum GameType {
        case create
        case guide
    }
    
    public enum BrocadeType {
        case small
        case normal
        case big
    }
    
    public enum SizeType {
        case rectangle
        case square
        case circular
    }
}
