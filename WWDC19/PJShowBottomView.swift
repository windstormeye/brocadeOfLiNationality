//
//  PJShowBottomView.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit


public class PJShowBottonView: UIView {
    
    var images: [UIImage]?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: screenHeight - height, width: screenWidth, height: height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView() {
        backgroundColor = .white
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        let itemW = 50
        let innerW = (screenWidth - 5 * 50) / 5
        collectionViewLayout.itemSize = CGSize(width: itemW , height: itemW)
        collectionViewLayout.minimumLineSpacing = innerW
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 0, left: innerW / 2,
                                                              bottom: 0, right: 0)
        
        let collectionView = PJLineCollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: collectionViewLayout)
        addSubview(collectionView)
        
        var viewModels = [PJLineCollectionViewCell.ViewModel]()
        for _ in 0...10 {
            let viewModel = PJLineCollectionViewCell.ViewModel(image: UIImage())
            viewModels.append(viewModel)
        }
        collectionView.viewModels = viewModels
        
    }
}
