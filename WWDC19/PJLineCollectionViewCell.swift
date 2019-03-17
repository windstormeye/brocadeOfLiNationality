//
//  PJLineCollectionViewCell.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

class PJLineCollectionViewCell: UICollectionViewCell {
//    var viewModel: ViewModel? {
//        didSet { setViewModel(viewModel!) }
//    }

    var viewModel: UIColor? {
        didSet { setViewModel(viewModel!) }
    }
    
    private func setViewModel(_ viewModel: UIColor) {
        backgroundColor = viewModel
    }
}

extension PJLineCollectionViewCell {
    struct ViewModel {
        var image: UIImage
    }
}
