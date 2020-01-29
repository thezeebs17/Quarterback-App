//
//  Quarterback.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/2/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import UIKit

struct QBKeys {
    static let name = "name"
    static let number = "number"
    static let completionCount = "completionCount"
    static let incompletionCount = "incompletionCount"
    static let attemptCount = "attemptCount"
    static let poorReadCount = "poorReadCount"
    static let poorThrowCount = "poorThrowCount"
    static let interceptionCount = "interceptionCount"
    static let dropCount = "dropCount"
    static let explosiveCount = "explosiveCount"
    static let withPressureCount = "withPressureCount"
    static let snapCount = "snapCount"
}


class Quarterback: NSObject, NSCoding {
    
    private var _name: String!
    private var _number: String!
    
    private var _poorReadCount: Int!
    private var _poorThrowCount: Int!
    
    private var _completionCount: Int!
    private var _incompletionCount: Int!
    private var _interceptionCount: Int!
    private var _dropCount: Int!
    private var _explosiveCount: Int!
    private var _attemptCount: Int!
    
    private var _withPressureCount: Int!
    
    private var _snapCount: Int!
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        if let nameObj = aDecoder.decodeObject(forKey: QBKeys.name) as? String {
            _name = nameObj
        }
        if let numberObj = aDecoder.decodeObject(forKey: QBKeys.number) as? String {
            _number = numberObj
        }
        if let completionCountObj = aDecoder.decodeObject(forKey: QBKeys.completionCount) as? Int {
            _completionCount = completionCountObj
        }
        if let attemptCountObj = aDecoder.decodeObject(forKey: QBKeys.attemptCount) as? Int {
            _attemptCount = attemptCountObj
        }
        if let poorReadCountObj = aDecoder.decodeObject(forKey: QBKeys.poorReadCount) as? Int {
            _poorReadCount = poorReadCountObj
        }
        if let poorThrowCountObj = aDecoder.decodeObject(forKey: QBKeys.poorThrowCount) as? Int {
            _poorThrowCount = poorThrowCountObj
        }
        if let interceptionCountObj = aDecoder.decodeObject(forKey: QBKeys.interceptionCount) as? Int {
            _interceptionCount = interceptionCountObj
        }
        if let dropCountObj = aDecoder.decodeObject(forKey: QBKeys.dropCount) as? Int {
            _dropCount = dropCountObj
        }
        if let explosiveCountObj = aDecoder.decodeObject(forKey: QBKeys.explosiveCount) as? Int {
            _explosiveCount = explosiveCountObj
        }
        if let withPressureCountObj = aDecoder.decodeObject(forKey: QBKeys.withPressureCount) as? Int {
            _withPressureCount = withPressureCountObj
        }
        if let snapCountObj = aDecoder.decodeObject(forKey: QBKeys.snapCount) as? Int {
            _snapCount = snapCountObj
        }
     }
    
    init(newName: String, newNumber: String) {
        super.init()
        self._name = newName
        self._number = newNumber
        self._snapCount = 0
        
        self._completionCount = 0
        self._incompletionCount = 0
        self._dropCount = 0
        self._interceptionCount = 0
        self._explosiveCount = 0
        self._attemptCount = 0
        
        self._poorReadCount = 0
        self._poorThrowCount = 0
        
        self._withPressureCount = 0
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: QBKeys.name)
        aCoder.encode(_number, forKey: QBKeys.number)
        aCoder.encode(_completionCount, forKey: QBKeys.completionCount)
        aCoder.encode(_incompletionCount, forKey: QBKeys.incompletionCount)
        aCoder.encode(_attemptCount, forKey: QBKeys.attemptCount)
        aCoder.encode(_poorReadCount, forKey: QBKeys.poorReadCount)
        aCoder.encode(_poorThrowCount, forKey: QBKeys.poorThrowCount)
        aCoder.encode(_interceptionCount, forKey: QBKeys.interceptionCount)
        aCoder.encode(_dropCount, forKey: QBKeys.dropCount)
        aCoder.encode(_explosiveCount, forKey: QBKeys.explosiveCount)
        aCoder.encode(_withPressureCount, forKey: QBKeys.withPressureCount)
        aCoder.encode(_snapCount, forKey: QBKeys.snapCount)
    }
    
    var name: String {
        get {return _name}
        set {_name = newValue}
    }
    
    var number: String {
        get {return _number}
        set { _number = newValue}
    }
    
    var completionCount: Int {
        get {return _completionCount}
        set { _completionCount = newValue}
    }
    
    var incompletionCount: Int {
        get {return _incompletionCount}
        set {_incompletionCount = newValue}
    }
    
    
    var attemptCount: Int {
        get {return _attemptCount}
        set { _attemptCount = newValue}
    }
    
    var poorReadCount: Int {
        get {return _poorReadCount}
        set { _poorReadCount = newValue}
    }
    
    var poorThrowCount: Int {
        get {return _poorThrowCount}
        set { _poorThrowCount = newValue}
    }
    
    var interceptionCount: Int {
        get {return _interceptionCount}
        set { _interceptionCount = newValue}
    }
    
    var dropCount: Int {
        get {return _dropCount}
        set { _dropCount = newValue}
    }
    
    var explosiveCount: Int {
        get {return _explosiveCount}
        set { _explosiveCount = newValue}
    }
    
    var withPressureCount: Int {
        get {return _withPressureCount}
        set { _withPressureCount = newValue}
    }
    
    var snapCount: Int {
        get {return _snapCount}
        set {_snapCount = newValue }
    }
}























