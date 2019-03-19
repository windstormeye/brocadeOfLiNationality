//
//  ShowContentView.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

public class PJShowContentView: UIView {
    var tempItem: PJShowItem? { didSet { didSetTempItem() }}
    
    var endTop: CGFloat? { return top }
    var endBottom: CGFloat? { return bottom }
    var endLeft: CGFloat? { return left }
    var endRight: CGFloat? { return width / 2 }
    
    var focusItems = [PJShowItem]()
    var copyItems = [PJShowItem]()
    // 注意：这里为三元组
    /// 底图上的数据
    var itemsFilter = [[PJShowItem]]()
    // 横向个数
    var itemXCount = 3 {
        didSet { initData() }
    }
    
    private var itemW = screenWidth / 6
    
    public override var frame: CGRect {
        didSet { initView() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView() {
        guard width != 0 else { return }

        let imgView = UIImageView(frame: CGRect(x: width / 2, y: 0,
                                                width: 5, height: height))
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
    }
    
    private func didSetTempItem() {
        focusItems.append(tempItem!)
        createCopyItem(tempItem!)
    }
    
    private func createCopyItem(_ focusItem: PJShowItem) {
        // 刚开始先顶出去
        let copyItem = PJShowItem(frame: CGRect(x: -1000, y: -1000,
                                                width: focusItem.width / 3 * 2,
                                                height: focusItem.height / 3 * 2))
        copyItem.tag = focusItem.tag
        copyItem.backgroundColor = focusItem.backgroundColor
        copyItem.isUserInteractionEnabled = false
        addSubview(copyItem)
        
        focusItem.panGestureX = { newCenter in
            let middleX = self.width / 2
            let middleW = middleX - newCenter.x
            let copyX = middleX + middleW
            
            copyItem.center = CGPoint(x: copyX, y: newCenter.y)
        }
        copyItems.append(copyItem)
        
        focusItem.panGestureEnd = {
            self.fitNearbyLocation(focusItem)
        }
    }
    
    func fitNearbyLocation(_ currentItem: PJShowItem) {
        let itemCenter = CGPoint(x: currentItem.x,
                                 y: currentItem.y)
        
        let itemXIndex = lroundf(Float(itemCenter.x / itemW))
        let finalItemCenterX = CGFloat(itemXIndex) * itemW
        
        let itemYIndex = Int(itemCenter.y / itemW)
        let finalItemCenterY = CGFloat(itemYIndex) * itemW
        
        if itemsFilter[itemYIndex][itemXIndex].tag == 0 {
            currentItem.x = finalItemCenterX
            currentItem.y = finalItemCenterY
            
            
            if currentItem.previousXIndex == nil {
                // 第一次
                currentItem.previousXIndex = itemXIndex
                currentItem.previousYIndex = itemYIndex
            } else {
                // 删除上一次的记录
                itemsFilter[currentItem.previousYIndex!][currentItem.previousXIndex!] = PJShowItem()
            }
            
            currentItem.currentXIndex = itemXIndex
            currentItem.currentYIndex = itemYIndex
            currentItem.previousYIndex = currentItem.currentYIndex
            currentItem.previousXIndex = currentItem.currentXIndex
            
            itemsFilter[itemYIndex][itemXIndex] = currentItem
        } else {
            currentItem.center = currentItem.oldCenter!
        }
        
        updateCopyItemPosition(currentItem.center,
                               currentItem.tag)
        
        // 判赢
        if PJShowItemCreator.shared.isWin(verifyItems: itemsFilter) {
            print("You Win!!!")
        } else {
            print("come on!!!")
        }
    }
    
    private func updateCopyItemPosition(_ itemCenter: CGPoint,
                                        _ itemTag: Int) {
        let copyItem = copyItems.filter { (item) -> Bool in
            if item.tag == itemTag { return true }
            return false
        }
        
        let middleX = width / 2
        let middleW = middleX - itemCenter.x
        let copyX = middleX + middleW
        
        copyItem[0].center = CGPoint(x: copyX, y: itemCenter.y)
    }
    
    private func initData() {
        itemW = screenWidth / CGFloat(itemXCount * 2)
        
        let XIndex = itemXCount
        let YIndex = Int((screenHeight - 64) / itemW)
        for _ in 0..<YIndex {
            var items = [PJShowItem]()
            for _ in 0..<XIndex {
                items.append(PJShowItem())
            }
            itemsFilter.append(items)
        }
    }
}
