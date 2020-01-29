//
//  SelectQuarterbacksDatasource.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/5/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class SelectQuarterbacksDatasource: Datasource {
    
    var categoryIndex = Int()
    
    var catQuarterbacks: [[Quarterback]] = {
        let defaults = UserDefaults.standard
        var players = [[Quarterback]]()
        if let savedQuarterbacks = defaults.object(forKey: "catQuarterbacks") as? Data {
            players = NSKeyedUnarchiver.unarchiveObject(with: savedQuarterbacks) as! [[Quarterback]]
        }
        return players
    }()
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [SelectQuarterbackCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if catQuarterbacks.count == 0 {
            return 0
        }
        return catQuarterbacks[categoryIndex][indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if catQuarterbacks.count == 0 || catQuarterbacks[categoryIndex].count == 0 {
            return 0
        }
        return catQuarterbacks[categoryIndex].count
    }
    
    
    
    
    
    
}











