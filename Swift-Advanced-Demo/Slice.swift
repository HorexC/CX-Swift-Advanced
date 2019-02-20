//
//  Slice.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/22.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

func SliceDemo() {
    let cities = ["New York", "Rio", "London", "Berlin", "Rome", "Beijing", "Tokyo", "Sydney"]
    
    let slice = cities[2...4]
    let _ = slice.startIndex
    let _ = slice.endIndex
}

struct Slice<Base: Collection>: Collection {
    typealias Index = Base.Index
    typealias IndexDistance = Base.IndexDistance
    
    let collection: Base
    
    var startIndex: Index
    var endIndex: Index
    
    init(base: Base, bounds: Range<Index>) {
        collection = base
        startIndex = bounds.lowerBound
        endIndex = bounds.upperBound

    }

    func index(after i: Base.Index) -> Base.Index {
        return collection.index(after: i)
    }
    
    subscript(position: Index) -> Base.Iterator.Element {
        return collection[position]
    }
    
    typealias SubSequence = Slice<Base>
    
    subscript(bounds: Range<Base.Index>) -> Slice<Base> {
        return Slice(base: collection, bounds: bounds)
    }
}

struct PrefixIterato<Base: Collection>: IteratorProtocol, Sequence {
    let base: Base
    var offset: Base.Index
    
    init(_ base: Base) {
        self.base = base
        self.offset = base.startIndex
    }
    
    mutating func next() -> Base.SubSequence? {
        guard offset != base.endIndex else { return nil }
        base.formIndex(after: &offset)
        return base.prefix(upTo: offset)
    }
}

