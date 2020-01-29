//
//  ChangeFolderDatasource.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/4/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class ChangeFolderDatasource: Datasource {
    
    var folders: [[String]] = {
        let defaults = UserDefaults.standard
        var gamePlanFolders = [[String]] ()
        
        if let savedAllFolders = defaults.object(forKey: "folders") as? Data {
            gamePlanFolders = NSKeyedUnarchiver.unarchiveObject(with: savedAllFolders) as! [[String]]
        }
        
        return gamePlanFolders
    }()
    
    var gamePlanIndex = Int()
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [StandardDatasourceCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if (folders[gamePlanIndex].count <= 0) {
            return 0
        }
        return folders[gamePlanIndex][indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return folders[gamePlanIndex].count
    }
    
}
















