//
//  Sequence.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/3.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

func SequenceDemo() {
    
//    for element in iterator {
//        
//    }
//    var iterator = someSequence.makeIterator()
//    while let element = iterator.next() {
//        
//    }
    
    let a = stride(from: 0, to: 10, by: 1)
    let b = a
    let _ = AnyIterator(b.makeIterator())
    
    func fibsIterator() -> AnyIterator<Int> {
        var statu = (0, 1)
        return AnyIterator{
            let upcomingNumber = statu.0
            statu = (statu.1, statu.0 + statu.1)
            return upcomingNumber
        }
    }
    
    let _ = sequence(first: 100) { (previous: UInt32) in
        let newValue = arc4random_uniform(previous)
        guard newValue > 0 else {
            return nil
        }
        return newValue
    }
    
    let _ = sequence(state: (0, 1)) { (state: inout (Int, Int)) -> Int? in
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

struct ConstantIterator: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}

struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return string[string.startIndex..<offset]
    }
}

struct PrefixSequence: Sequence {
    let string: String
    
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

//protocol Sequence {
//    associatedtype Iterator: IteratorProtocol
//    func makeIterator() -> Iterator
//}

//protocol IteratorProtocol {
//    associatedtype Element
//    mutating func next() -> Element?
//}
