//
//  NewGamePlan.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/4/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class NewGamePlanController: UIViewController {
    
    var allFolderNames = [[String]]()
    var allGamePlanNames = [String]()
    
    let newGamePlanNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Game Plan"
        textField.textAlignment = .center
        textField.backgroundColor = .yellow
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNewGamePlanName), for: .touchUpInside)
        return button
    }()
    
    let newGamePlanNameTopConst: CGFloat = 100
    let newGamePlanNameSqueezeConst: CGFloat = 80
    let newGamePlanNameWidthConst: CGFloat = 80
    let newGamePlanNameHeightConst: CGFloat = 50
    
    var gamePlanIndex = Int()
    var folderIndex = Int()
    
    var gamePlans = [String]()
    var gamePlanFolders = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        setUpNavItems()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func setUpNavItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
        saveButton.setTitleColor(UIColor.gray, for: .disabled)
    }
    
    func setUpViews() {
        view.addSubview(newGamePlanNameTextField)
        newGamePlanNameTextField.anchor(view.topAnchor,
                                        left: view.leftAnchor,
                                        bottom: nil,
                                        right: view.rightAnchor,
                                        topConstant: newGamePlanNameTopConst,
                                        leftConstant: newGamePlanNameSqueezeConst,
                                        bottomConstant: 0,
                                        rightConstant: newGamePlanNameSqueezeConst,
                                        widthConstant: newGamePlanNameWidthConst,
                                        heightConstant: newGamePlanNameHeightConst)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.hasText {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @objc func saveNewGamePlanName(sender: Any) {
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
        
        if newGamePlanNameTextField.hasText {
            gamePlans.append(newGamePlanNameTextField.text!)
            gamePlanFolders.append([String]())
            gamePlanIndex = gamePlans.count - 1
            var categories = [[[String]]]()
            if let savedCategories = defaults.object(forKey: "allCategories") as? Data {
                categories = NSKeyedUnarchiver.unarchiveObject(with: savedCategories) as! [[[String]]]
            }
            categories.append([[String]]())
            let saveCategories = NSKeyedArchiver.archivedData(withRootObject: categories)
            defaults.set(saveCategories, forKey: "allCategories")
            let saveGamePlanIndex = NSKeyedArchiver.archivedData(withRootObject: gamePlanIndex)
            let saveGamePlans = NSKeyedArchiver.archivedData(withRootObject: gamePlans)
            let saveGamePlanFolders = NSKeyedArchiver.archivedData(withRootObject: gamePlanFolders)
            defaults.set(saveGamePlanIndex, forKey: "gamePlanIndex")
            defaults.set(saveGamePlans, forKey: "gamePlans")
            defaults.set(saveGamePlanFolders, forKey: "folders")
            UserDefaults.standard.synchronize()
        }
        self.navigationController?.popViewController(animated: true)
        //        let segueNewFolder = NewFolderController()
        //        segueNewFolder.title = gamePlans[gamePlanIndex]
        //        self.navigationController?.present(segueNewFolder,
        //                                           animated: true,
        //                                           completion: nil)
    }
    
}









