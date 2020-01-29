//
//  CategoriesDatasourceController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/2/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

func createQuarterbacks() -> [Quarterback] {
    let chaseGarbers = Quarterback(newName: "Chase Garbers", newNumber: "7")
    let robbyRowell = Quarterback(newName: "Robby Rowell", newNumber: "13")
    let devonModster = Quarterback(newName: "Devon Modster", newNumber: "18")
    return [chaseGarbers, robbyRowell, devonModster]
    
}

class CategoriesDatasourceController: DatasourceController {

    var gamePlans = [String]()
    var folders = [[String]]()
    var gamePlanIndex = Int()
    var folderIndex = Int()
    var allCategories = [String]()
    var quarterbacks = [Quarterback]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpNavItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCoreData()
        setUpNavItems()
        self.datasource = CategoriesDatasource()
    }
    
    
    func setUpNavItems() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
//        if (!(gamePlans.count != 0 && folders[gamePlanIndex].count != 0)) {
//            addButton.isEnabled = false
////            addButton.tintColor = .gray
//        } else {
//            addButton.isEnabled = true
//            navigationItem.prompt = gamePlans[gamePlanIndex]
//            navigationItem.title = folders[gamePlanIndex][folderIndex]
//        }
    }
    
    @objc func addTapped(sender: UIButton) {
        let segueAddButton = AddCategoryController()
        navigationController?.pushViewController(segueAddButton, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 70
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func loadCoreData() {
        let defaults = UserDefaults.standard
        if let savedGamePlans = defaults.object(forKey: "gamePlans") as? Data {
            gamePlans = NSKeyedUnarchiver.unarchiveObject(with: savedGamePlans) as! [String]
        }
        if let savedFolders = defaults.object(forKey: "folders") as? Data {
            folders = NSKeyedUnarchiver.unarchiveObject(with: savedFolders) as! [[String]]
        }
        if let savedGamePlanIndex = defaults.object(forKey: "gamePlanIndex") as? Data {
            gamePlanIndex = NSKeyedUnarchiver.unarchiveObject(with: savedGamePlanIndex) as! Int
        }
        if let savedFolderIndex = defaults.object(forKey: "folderIndex") as? Data {
            folderIndex = NSKeyedUnarchiver.unarchiveObject(with: savedFolderIndex) as! Int
        }
        if let savedAllCategories = defaults.object(forKey: "allCategories") as? Data {
            allCategories = NSKeyedUnarchiver.unarchiveObject(with: savedAllCategories) as! [String]
        }
        if let savedQuarterbacks = defaults.object(forKey: "quarterbacks") as? Data {
            quarterbacks = NSKeyedUnarchiver.unarchiveObject(with: savedQuarterbacks) as! [Quarterback]
        } else {
            quarterbacks = createQuarterbacks()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let segueController = SelectQuarterbackDatasourceController()
        segueController.title = self.datasource?.item(indexPath) as! String
        segueController.categoryIndex = indexPath.row
//        segueController.navigationItem.backBarButtonItem?.title = " "
        navigationController?.pushViewController(segueController, animated: true)
    }
    
    
}











