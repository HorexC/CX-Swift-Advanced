//
//  Dictionary.swift
//  Swift-Advanced-Demo
//
//  Created by horex on 2017/8/2.
//  Copyright © 2017年 horex. All rights reserved.
//

import Foundation

struct Person {
    var name: String
    var zipCode: Int
    var brithday: Date
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.zipCode == rhs.zipCode && lhs.brithday == rhs.brithday
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return name.hashValue ^ zipCode.hashValue ^ brithday.hashValue
    }
}

func DictionaryDemo() {
    
    enum Setting {
        case text(String)
        case int(Int)
        case bool(Bool)
    }
    
    let defaultSettings: [String: Setting] = [
        "Airplane Mode": .bool(true),
        "Name": .text("My iPhone"),
    ]
    let _ = defaultSettings["Name"]
    
    var localizedSettings: [String: String] = [:]
    localizedSettings["Name"] = "Mein iPhone"
    localizedSettings["Do Not Disturb"] = "true"
    
    let _ = localizedSettings.updateValue("", forKey: "")
    
    let defaultAlarms = (1..<5).map{ (key: "Alarm\($0)", value: false) }
    let _ = Dictionary(defaultAlarms)
    
    let _ = defaultSettings.mapValues{ setting -> String in
        switch setting {
        case .text(let text): return text
        case .int(let number): return String(number)
        case .bool(let value): return String(value)
        }
    }
    

}

extension Dictionary {
    mutating func merge<S>(_ other: S) where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        self.merge(sequence)
    }
    
    func mapValues<NewValue>(transform: (Value) -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>(map{ (key, value) in
            return (key, transform(value))
        })
    }
}

