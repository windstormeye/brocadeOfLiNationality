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
    
    private var itemTag = 101
    
    public override func loadView() {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.backgroundColor = brocadeBackgroundColor
        
        let contentView = PJShowContentView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height - 64))
        
        switch brocadeType {
        case .normal: break
        case .small: contentView.itemXCount = 2
        case .big: contentView.itemXCount = 4
        }
        
        view.addSubview(contentView)
        
        PJShowItemCreator.shared.brocadeType = brocadeType
        
        let bottomView = PJShowBottonView(height: 64, longPressView: view)
        view.addSubview(bottomView)
        let colors = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.brown, UIColor.gray, UIColor.black, UIColor.brown, UIColor.darkGray, UIColor.lightGray, UIColor.cyan]
        bottomView.viewModel = colors
        
        bottomView.moveCell = { cellIndex, centerPoint in
            guard let tempItem = contentView.tempItem else { return }
            tempItem.center = CGPoint(x: centerPoint.x,
                                      y: centerPoint.y + bottomView.top)
        }
        
        bottomView.moveBegin = { cellIndex in
            let itemW = screenWidth / CGFloat(contentView.itemXCount * 2)
            // 刚开始的初始化先让其消失
            let moveItem = PJShowItem(frame: CGRect(x: -1000, y: -1000,
                                                    width: itemW, height: itemW))
            moveItem.endTop = 0
            moveItem.endBottom = contentView.height
            moveItem.endLeft = 0
            moveItem.endRight = contentView.width / 2
            moveItem.backgroundColor = bottomView.viewModel![cellIndex]
            moveItem.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            moveItem.tag = self.itemTag
            self.itemTag += 1
            
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
