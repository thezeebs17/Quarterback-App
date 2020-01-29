//
//  OptionsController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/4/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit


class OptionsController: UITableViewController {
    
    let headerFooterHeight: CGFloat = 23
    let sectionsCount: Int = 2
    let headerFooterBackgroundColor = UIColor.init(r: 240, g: 240, b: 240)
    
    var gamePlanIndex = Int()
    var folderIndex = Int()
    
    var gamePlans = [String]()
    var gamePlanFolders = [[String]]()
    
    let gamePlanOptions: [String] = ["New Folder",
                                     "Change Folder",
                                     "New Game Plan",
                                     "Change Game Plan",
                                     "Edit Game Plans & Folders"/*,
         "Export Data for all Folders in Current Game Plan"*/]
    
    let deleteOptions: [String] = ["Delete Snap Counts in Folder",
                                   "Delete All Snap Counts in Game Plan",
                                   "Delete All Snap Counts on Device"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StandardTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCoreData()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Game Plan Options"
        } else {
            return "Delete Options"
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = headerFooterBackgroundColor
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerView.addSubview(label)
        label.anchor(nil,
                     left: headerView.leftAnchor,
                     bottom: headerView.bottomAnchor,
                     right: headerView.rightAnchor,
                     topConstant: 0,
                     leftConstant: 5,
                     bottomConstant: 1,
                     rightConstant: 0,
                     widthConstant: 0,
                     heightConstant: 0)
        label.sizeToFit()
        //label.textAlignment = .left
        headerView.backgroundColor = headerFooterBackgroundColor
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerFooterHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return headerFooterHeight
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return gamePlanOptions.count
        } else {
            return deleteOptions.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardTableViewCell")
        cell?.isUserInteractionEnabled = true
        cell?.textLabel?.textColor = .black
        if indexPath.section == 0 {
            cell?.textLabel?.text = gamePlanOptions[indexPath.row]
            
            if indexPath.row == 0 && gamePlanIndexOutOfBounds() {
                cell?.isUserInteractionEnabled = false
                cell?.textLabel?.textColor = .gray
            }
            if ((indexPath.row == 1 && gamePlanFolderIndexOutOfBounds())
                || (indexPath.row == 3 && gamePlanIndexOutOfBounds())) {
                cell?.isUserInteractionEnabled = false
                cell?.textLabel?.textColor = .gray
            }
            if (indexPath.row == 4 && gamePlanIndexOutOfBounds()) {
                cell?.isUserInteractionEnabled = false
                cell?.textLabel?.textColor = .gray
            }
        } else {
            cell?.textLabel?.text = deleteOptions[indexPath.row]
        }
        return cell!
    }
    
    private func gamePlanFolderIndexOutOfBounds() -> Bool {
        if gamePlanIndexOutOfBounds() {
            return true
        }
        if (folderIndex >= 0 && folderIndex < gamePlanFolders[gamePlanIndex].count) {
            return false
        }
        return true
    }
    
    private func gamePlanIndexOutOfBounds() -> Bool {
        if (gamePlanIndex >= 0 && gamePlanIndex < gamePlans.count) {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // Create New Folder screen
                let segueNewFolder = NewFolderController()
                segueNewFolder.gamePlanName = gamePlans[gamePlanIndex]
                segueNewFolder.title = "Enter New Folder"
                navigationController?.pushViewController(segueNewFolder, animated: true)
                
            } else if indexPath.row == 1 {
                // Change Folder Screen
                let segueChangeFolder = ChangeFolderDatasourceController()
                segueChangeFolder.title = "Change Folder"
                segueChangeFolder.gamePlanName = gamePlans[gamePlanIndex]
                
                navigationController?.pushViewController(segueChangeFolder, animated: true)
            } else if indexPath.row == 2 {
                // Create New Game Plan
                let segueNewGamePlan = NewGamePlanController()
                segueNewGamePlan.title = "Enter New Game Plan"
                navigationController?.pushViewController(segueNewGamePlan, animated: true)
            } else if indexPath.row == 3 {
                // Change Game Plan Screen
            } else if indexPath.row == 4 {
                // Edit Game Plans & Folders
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                // Delete Snap Counts in Folder
            } else if indexPath.row == 1 {
                // Delete All Snap Counts in Game Plan
            } else if indexPath.row == 2 {
                // Delete All SnapCounts on Device
            }
        }
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


