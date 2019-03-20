//
//  PJCreator.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/18.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import Foundation

class PJShowItemCreator {
    static let shared = PJShowItemCreator()
    
    // 目标
    var focusArr: [[Int]]? { return getFocusArr() }
    var brocadeType: PJHomeViewController.BrocadeType = .normal
    
    private func getFocusArr() -> [[Int]] {
        var fo = [[Int]]()
        
        switch brocadeType {
        case .normal:
            fo = [
                [0, 1, 0],
                [0, 2, 0],
                [0, 0, 0],
                [0, 0, 0],
                [0, 0, 0],
                [0, 0, 0],
                [0, 0, 0],
                [0, 0, 0],
                [0, 0, 0],
                [0, 0, 0],
            ]
        case .small:
            fo = [
                [0, 1],
                [0, 2],
                [0, 0],
                [0, 0],
                [0, 0],
                [0, 0],
            ]
        case .big:
            fo = [
                [0, 1, 0, 0],
                [0, 2, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
            ]
        }
        
        return fo
    }
    
    func isWin(verifyItems: [[PJShowItem]]) -> Bool {
        guard let focusArr = focusArr else { return false }
        
        for x in 0..<focusArr.count {
            for y in 0..<verifyItems[x].count {
                let itemTag = verifyItems[x][y].tag - 100
                guard focusArr[x][y] != 0 else { continue }
                
                if itemTag != focusArr[x][y] {
                    return false
                }
            }
        }
        return true
    }
}
