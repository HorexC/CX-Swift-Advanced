//
//  List.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/3.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

fileprivate enum ListNode<Element> {
    case end
    indirect case node(Element, next: ListNode<Element>)
    
    func cons(_ x: Element) -> ListNode<Element> {
        return .node(x, next: self)
    }
}

public struct ListIndex<Element>: CustomStringConvertible {
    fileprivate let node: ListNode<Element>
    fileprivate let tag: Int
    
    public var description: String {
        return "ListIndex\(tag)"
    }
}

extension ListIndex: Comparable {
    public static func ==<T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    public static func <<T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return lhs.tag < rhs.tag
    }
}

public struct ListStruct<Element>: Collection {
    
    public typealias Index = ListIndex<Element>
    
    public var startIndex: Index
    public var endIndex: Index
    
    public subscript(position: Index) -> Element {
        switch position.node {
        case .end: fatalError()
        case let .node(x, _): return x
        }
    }
    
    public func index(after idx: Index) -> Index {
        switch idx.node {
        case .end:
            fatalError()
        case let .node(_, next): return Index(node: next, tag: idx.tag - 1)
        }
    }
}

extension ListStruct: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        startIndex = ListIndex(node: elements.reversed().reduce(.end) {
            partialList, element in
            partialList.cons(element)
        }, tag: elements.count)
        endIndex = ListIndex(node: .end, tag: 0)
    }
}

extension ListStruct: CustomStringConvertible {
    public var description: String {
        let elements = self.map { String(describing: $0) }.joined(separator: ",")
        return "ListStruct(\(elements))"
    }
}

extension ListStruct {
    public var count: Int {
        return startIndex.tag - endIndex.tag
    }
}

enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}

extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}

func ListDemo() {
    let _ = List<Int>.end.cons(1).cons(2).cons(3)

    let list = [1, 2, 3, 4, 5]
    let onePastStart = list.index(after: list.startIndex)
    let firstDropped = list[onePastStart..<list.endIndex]
    Array(firstDropped)
    
}
