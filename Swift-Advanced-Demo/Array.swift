//
//  Array.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/2.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

func ArrayDemo() {
    
    let fibs = [0, 1, 1, 2, 3, 5]
    
    func base() {
        
        var mutableFibs = [0, 1, 1, 2, 3, 5]
        
        mutableFibs.append(8)
        
        mutableFibs.append(contentsOf: [13, 15])
        
        let x = [1, 2, 3]
        var y = x
        y.append(4)
        
        // y = [1, 2, 3, 4]
        // x = [1, 2, 3]”
        
        let array = [1, 2, 3]
        for _ in array {}
        
        for _ in array.dropFirst() {}
        
        for (_, _) in array.enumerated() {}
        
        if array.index(where: { (x) -> Bool in
            return x == 1
        }) != nil {}
        
        let _ = array.map { (x) -> Int in
            return x + 1
        }
        
        let _ = array.filter { (x) -> Bool in
            return x != 1
        }
        
    }

    
    func mapDemo() {
        let fibs = [0, 1, 1, 2, 3, 5]

        var squared: [Int] = []
        
        for fib in fibs {
            squared.append(fib * fib)
        }
        
        squared = fibs.map{ fib in fib * fib }
        
    }
    
    func myContain() {
        let names = ["Paula", "Elena", "Zoe"]
        var lastNameEndingInA: String?
        for name in names where name.hasSuffix("a") {
            lastNameEndingInA = name
            break
        }
        print(lastNameEndingInA ?? "")
        lastNameEndingInA = names.last{ $0.hasSuffix("a") }
    }
    
    func filterDemo() {
        var nums = [1, 2, 3]
        nums = nums.filter{ num in num / 2 == 0 }
        nums = nums.filter{ $0 / 2 == 0 }
        
    }
    
    func reduceDemo() {
        var total = 0
        for num in fibs {
            total = total + num
        }
        let _ = fibs.reduce(0) { total, num in total + num}
        let _ = fibs.reduce(0, +)
        let _ = fibs.reduce("") { str, num in str + "\(num)"}
        
    }
    
    func flatMapDemo() {
        let suits = ["♥️", "♠️", "♣️", "♦️"]
        let ranks = ["J", "Q", "K", "A"]
        
        let result = suits.flatMap { suit in
            ranks.map{rank in
                (suit, rank)
            }
        }
        
        print(result)
        
        let result2 = suits.map { suit in
            ranks.map{rank in
                (suit, rank)
            }
        }
        
        print(result2)
    }
    
    func forEachDemo() {
        for _ in fibs {}
        
        fibs.forEach{ element in
            print(element)
        }
        print(["a","c","b"].indices)
        
        (0..<10).forEach{ element in
            print(element)
            if element > 2 {
                return
            }
        }
    }
    
    func sliceDemo() {
        let slice = fibs[1..<fibs.endIndex]
        let _ = type(of: slice)
        let _ = Array(fibs[1..<fibs.endIndex])
    }

}

extension Sequence {
    func last(where predice:(Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predice(element) {
            return element
        }
        return nil
    }
}

extension Array {
    func map<T>(_ transform:(Element) -> T) ->[T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
    
    func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result:[T] = []
        for x in self {
            result.append(contentsOf: transform(x))
        }
        return result
    }
    
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map{ next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
    func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
    
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
    
    func map2<T>(_ transform:(Element) -> T) -> [T] {
        return reduce([]) {
            return $0 + [transform($1)]
        }
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            return isIncluded($1) ? $0 + [$1] : $0
        }
    }
}

extension Array where Element: Equatable {
    func index(of element: Element) -> Int? {
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
    
    func index_foreach(of element: Element) -> Int? {
        self.indices.filter{ idx in
            self[idx] == element
            }.forEach{ idx in
                // return idx
            }
        return nil
    }
}



