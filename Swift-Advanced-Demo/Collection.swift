//
//  Collection.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/3.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

protocol Queue {
    associatedtype Element
    
    mutating func enqueue(_ newElement: Element)
    
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    fileprivate var left: [Element] = []
    fileprivate var right: [Element] = []
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> (Element)? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}


extension FIFOQueue: Collection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }
    
    func index(after i: Int) -> Int {
        precondition( i<endIndex )
        return i + 1
    }
    subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "Indec our of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
}

extension FIFOQueue: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(left: elements.reversed(), right: [])
    }
}







