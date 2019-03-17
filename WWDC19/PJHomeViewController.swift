//
//  ViewController.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

public class PJHomeViewController: UIViewController {

    public override func viewDidLoad() {
        
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    
    
    public override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .bgColor()
        
        let contentView = PJShowContentView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height - 64))
        view.addSubview(contentView)
        
        let bottomView = PJShowBottonView(height: 64, longPressView: view)
        view.addSubview(bottomView)
        let colors = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.brown, UIColor.gray, UIColor.black, UIColor.brown, UIColor.darkGray, UIColor.lightGray, UIColor.cyan]
        bottomView.viewModel = colors
        
        bottomView.moveCell = { cellIndex, centerPoint in
            guard let tempItem = contentView.tempItem else { return }
            tempItem.center = CGPoint(x: centerPoint.x, y: centerPoint.y + bottomView.top)
        }
        
        bottomView.moveBegin = { cellIndex in
            // 刚开始的初始化先让其消失
            let moveItem = PJShowItem(frame: CGRect(x: -100, y: -100, width: 50, height: 50))
            moveItem.endTop = 0
            moveItem.endBottom = contentView.height
            moveItem.endLeft = 0
            moveItem.endRight = contentView.width / 2
            moveItem.backgroundColor = colors[cellIndex]
            moveItem.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            contentView.addSubview(moveItem)
            contentView.tempItem = moveItem
        }
        
        bottomView.moveEnd = {
            guard let tempItem = contentView.tempItem else { return }
            tempItem.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }


}

