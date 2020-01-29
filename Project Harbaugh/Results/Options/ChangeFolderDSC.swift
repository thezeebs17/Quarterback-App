//
//  ChangeFolderDSC.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/4/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class ChangeFolderDatasourceController: DatasourceController {
    
    var gamePlanName = String()
    var gamePlanIndex = Int()
    var folderIndex = Int()
    
    var gamePlans = [String]()
    var gamePlanFolders = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        let datasource = ChangeFolderDatasource()
        datasource.gamePlanIndex = Int()
        self.datasource = datasource
        
        setUpNavItems()
        collectionView?.backgroundColor = UIColor.init(r: 230, g: 230, b: 230)
        //        self.datasource = rosterDatasource
    }
    
    func setUpNavItems() {
        self.navigationItem.prompt = gamePlanName
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: gamePlanName,
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat
        height = 50
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func loadCoreData() {
        let defaults = UserDefaults.standard
        if let savedGamePlanIndex = defaults.object(forKey: "gamePlanIndex") as? Data {
            gamePlanIndex = NSKeyedUnarchiver.unarchiveObject(with: savedGamePlanIndex) as! Int
        }
        if let savedFolderIndex = defaults.object(forKey: "folderIndex") as? Data {
            folderIndex = NSKeyedUnarchiver.unarchiveObject(with: savedFolderIndex) as! Int
        }
        if let savedGamePlans = defaults.object(forKey: "gamePlans") as? Data {
            gamePlans = NSKeyedUnarchiver.unarchiveObject(with: savedGamePlans) as! [String]
        }
        if let savedGamePlanFolders = defaults.object(forKey: "folders") as? Data {
            gamePlanFolders = NSKeyedUnarchiver.unarchiveObject(with: savedGamePlanFolders) as! [[String]]
        }
    }
}





















