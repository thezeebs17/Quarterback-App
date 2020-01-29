//
//  PlayResult.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 11/9/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

//
//  Quarterback.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/2/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import UIKit

struct PlayResultKeys {
    static let quarterbackName = "name"
    static let quarterbackNumber = "number"
    static let quarterbackIndex = "quarterbackIndex"
    static let playCount = "playCount"
    static let catchRating = "catchRating"
    static let poorPassRating = "poorPassRating"
    static let withPressureRating = "withPressureRating"
    static let comment = "comment"
}


class PlayResult: NSObject, NSCoding {
    
    private var _quarterbackName: String!
    private var _quarterbackNumber: String!
    private var _quarterbackIndex: Int!
    private var _playCount: String!
    
    private var _catchRating: String!
    private var _poorPassRating: String!
    private var _withPressureRating: String!
    
    private var _comment: String!
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        if let quarterbackNameObj = aDecoder.decodeObject(forKey: PlayResultKeys.quarterbackName) as? String {
            _quarterbackName = quarterbackNameObj
        }
        if let quarterbackNumberObj = aDecoder.decodeObject(forKey: PlayResultKeys.quarterbackNumber) as? String {
            _quarterbackNumber = quarterbackNumberObj
        }
        if let quarterbackIndexObj = aDecoder.decodeObject(forKey: PlayResultKeys.quarterbackIndex) as? Int {
            _quarterbackIndex = quarterbackIndexObj
        }
        
        if let playCountObj = aDecoder.decodeObject(forKey: PlayResultKeys.playCount) as? String {
            _playCount = playCountObj
        }
        if let catchRatingObj = aDecoder.decodeObject(forKey: PlayResultKeys.catchRating) as? String {
            _catchRating = catchRatingObj
        }
        if let poorPassRatingObj = aDecoder.decodeObject(forKey: PlayResultKeys.poorPassRating) as? String {
            _poorPassRating = poorPassRatingObj
        }
        if let withPressureRatingObj = aDecoder.decodeObject(forKey: PlayResultKeys.poorPassRating) as? String {
            _withPressureRating = withPressureRatingObj
        }
        if let commentObj = aDecoder.decodeObject(forKey: PlayResultKeys.comment) as? String {
            _comment = commentObj
        }
    }
    
    init(newQuarterbackName: String,
         newQuarterbackNumber: String,
         newQuarterbackIndex: Int,
         newPlayCount: String,
         newCatchRating: String,
         newPoorPassRating: String,
         newWithPressureRating: String) {
        super.init()
        self._quarterbackName = newQuarterbackName
        self._quarterbackNumber = newQuarterbackNumber
        self._quarterbackIndex = newQuarterbackIndex
        self._playCount = newPlayCount
        self._catchRating = newCatchRating
        self._poorPassRating = newPoorPassRating
        self._withPressureRating = newWithPressureRating
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_quarterbackName, forKey: PlayResultKeys.quarterbackName)
        aCoder.encode(_quarterbackNumber, forKey: PlayResultKeys.quarterbackNumber)
        aCoder.encode(_quarterbackIndex, forKey: PlayResultKeys.quarterbackIndex)
        aCoder.encode(_playCount, forKey: PlayResultKeys.playCount)
        aCoder.encode(_catchRating, forKey: PlayResultKeys.catchRating)
        aCoder.encode(_poorPassRating, forKey: PlayResultKeys.poorPassRating)
        aCoder.encode(_withPressureRating, forKey: PlayResultKeys.withPressureRating)
        aCoder.encode(_comment, forKey: PlayResultKeys.comment)
    }
    
    var quarterbackName: String {
        get {return _quarterbackName}
        set {_quarterbackName = newValue}
    }
    
    var quarterbackNumber: String {
        get {return _quarterbackNumber}
        set { _quarterbackNumber = newValue}
    }
    
    var quarterbackIndex: Int {
        get {return _quarterbackIndex}
        set {_quarterbackIndex = newValue}
    }
    
    var playCount: String {
        get {return _playCount}
        set {_playCount = newValue}
    }
    var catchRating: String {
        get {return _catchRating}
        set {_catchRating = newValue}
    }
    var poorPassRating: String {
        get {return _poorPassRating}
        set {_poorPassRating = newValue}
    }
    var withPressureRating: String {
        get {return _withPressureRating}
        set {_withPressureRating = newValue}
    }
    
    var comment: String {
        get {return _comment}
        set {_comment = newValue}
    }
}
























