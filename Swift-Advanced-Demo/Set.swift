//
//  Set.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/3.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

func SetDemo() {
    
    let naturals: Set = [1, 2, 3, 2]
    
    let _ = naturals.contains(3)
    
    let iPods: Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "iPod Classic"]
    let discontinuedIPods: Set = ["iPod mini", "iPod Classic"]
    let touchscreen: Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
    
    let _ = iPods.subtracting(discontinuedIPods)
    let _ = iPods.intersection(discontinuedIPods)
    let _ = iPods.union(discontinuedIPods)
    
    var indices = IndexSet()
    indices.insert(integersIn: 1..<5)
    indices.insert(integersIn: 11..<15)
    
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}
