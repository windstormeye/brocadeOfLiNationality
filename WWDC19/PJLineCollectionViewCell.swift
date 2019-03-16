//
//  PJLineCollectionViewCell.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

class PJLineCollectionViewCell: UICollectionViewCell {
    var viewModel: ViewModel? {
        didSet { setViewModel(viewModel!) }
    }
    
    private func setViewModel(_ viewModel: ViewModel) {
        let coloes = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.brown, UIColor.gray]
        
        let c = NSInteger.random(in: 0...4)
        backgroundColor = coloes[c]
    }
}

extension PJLineCollectionViewCell {
    struct ViewModel {
        var image: UIImage
    }
}
