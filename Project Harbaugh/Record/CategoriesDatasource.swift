//
//  CategoriesDatasource.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/2/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class CategoriesDatasource: Datasource {
    
    var gamePlanIndex = Int()
    var folderIndex = Int()
    
    var categories: [String] = {
        let defaults = UserDefaults.standard
        var allCategories = [String]()
        if let savedAllCategories = defaults.object(forKey: "allCategories") as? Data {
            allCategories = NSKeyedUnarchiver.unarchiveObject(with: savedAllCategories) as! [String]
        }
        
        return allCategories
    }()
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [CategoryCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if categories.count <= 0 {
            return 0
        }
        return categories[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if categories.count == 0 || categories[gamePlanIndex].count == 0 {
            return 0
        }
        return categories.count
    }
    
}

















