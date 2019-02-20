//
//  Option.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/22.
//  Copyright © 2017年 horex. All rights reserved.
//

import UIKit

func OptionDemo() {
    var array = ["one", "two", "three"]
    let idx = array.index(of: "four")
    switch idx {
    case .some(let idx):
        array.remove(at: idx)
    case .none:
        break
    }
    
    let urlString = "http://www.objc.io/logo.png"
    
//    if let url = URL(string: urlString), url.pathExtension == "png" , let data = try? Data(contentsOf: url), let _ = UIImage(data: data) {
//        
//    }
    
    func readLine() -> Int? {
        return nil
    }
    while let line = readLine() {
        print(line)
    }
    
    var iterator = array.makeIterator()
    
    while let i = iterator.next() {
        print(i)
    }
    
    for i in 0..<10 where i % 2 == 0 {
        print(i)
    }
    
    var a: [() -> Int] = []
    for i in 1...3 {
        a.append{ i }
    }
    
    var g = (1...3).makeIterator()
    var o: Int? = g.next()
    while o != nil {
        let i = o!
        a.append{ i }
        o = g.next()
    }
    
    do {
        var g = (1...3).makeIterator()
        var i: Int
        while o != nil {
            i = o!
            a.append{ i }
            o = g.next()
        }
    }
    
    let s = "Taylor Swift"
    if case Substring("swift") = s {
        
    }
    
    let i: Int? = nil
    let j: Int? = nil
    let k: Int? = 42
    let _ = i ?? j ?? k
    
    let s1: String?? = nil
    let _ = (s1 ?? "inner") ?? "outer" // inner
    let s2: String?? = .some(nil)
    let _ = (s2 ?? "inner") ?? "outer" // inner
}

//extension String {
//    var fileExtension: String? {
//        guard let period = characters.index(of: ".") else { return nil }
//        let extensionRange = index(after: period)..<characters.endIndex
//        return self[extensionRange]
//    }
//}

enum Option<Wrapper> {
    case none
    case some(Wrapper)
}

func unimplemented() -> Never {
    fatalError()
}

extension Collection where Iterator.Element: Equatable {
    func index(of element:Iterator.Element) -> Option<Index> {
        var idx = startIndex
        while idx != endIndex {
            if self[idx] == element {
                return .some(idx)
            }
            formIndex(after: &idx)
        }
        return .none
    }
}

struct Substring {
    let s: String
    init(_ s: String) {
        self.s = s
    }
}

func ~=(pattern: Substring, value: String) -> Bool {
    return value.range(of: pattern.s) != nil
}

extension Int {
    var half: Int? {
        guard self > 1 else {
            return nil
        }
        return self / 2
    }
}

extension Array {
    subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}

extension Optional {
    func map<U>(transform: (Wrapped) -> U) -> U? {
        if let value = self {
            return transform(value)
        }
        return nil
    }
}
