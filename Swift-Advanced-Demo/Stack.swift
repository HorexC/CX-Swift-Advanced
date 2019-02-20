//
//  Stack.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/4.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

func StackDemo() {
    var stack: List<Int> = [3, 2, 1]
    var a = stack
    var b = stack
    
    a.pop()
    a.pop()
    a.pop()
    
    stack.pop()
    stack.push(4)
    
    b.pop()
    
}

protocol Stack {
    associatedtype Element
    
    mutating func push(_ x: Element)
    
    @discardableResult mutating func pop() -> Element?
}

extension Array: Stack {
    mutating func push(_ x: Element) {
        append(x)
    }
    
    @discardableResult mutating func pop() -> Element? {
        return popLast()
    }
}

extension List: Stack {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    
    @discardableResult mutating func pop() -> (Element)? {
        switch self {
        case .end:
            return nil
        case let .node(x, next: xs):
            self = xs
            return x
        }
    }
}
