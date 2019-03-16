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
        
        let bottomView = PJShowBottonView(height: 64)
        view.addSubview(bottomView)
    }


}

