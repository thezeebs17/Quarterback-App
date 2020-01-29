//
//  NewFolderController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/4/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class NewFolderController: UIViewController, UITextFieldDelegate {
    
    let newFolderNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Folder Name"
        textField.textAlignment = .center
        textField.backgroundColor = .green
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNewFolderName), for: .touchUpInside)
        return button
    }()
    
    let newFolderNameTopConst: CGFloat = 100
    let newFolderNameSqueezeConst: CGFloat = 80
    let newFolderNameWidthConst: CGFloat = 80
    let newFolderNameHeightConst: CGFloat = 50
    
    var gamePlanName = String()
    
    var gamePlanIndex = Int()
    var folderIndex = Int()
    
    var gamePlans = [String]()
    var gamePlanFolders = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        newFolderNameTextField.delegate = self
        
        setUpNavItems()
        setUpViews()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func setUpNavItems() {
        navigationItem.prompt = gamePlanName
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
        saveButton.setTitleColor(UIColor.gray, for: .disabled)
    }
    
    func setUpViews() {
        view.addSubview(newFolderNameTextField)
        newFolderNameTextField.anchor(view.topAnchor,
                                      left: view.leftAnchor,
                                      bottom: nil,
                                      right: view.rightAnchor,
                                      topConstant: newFolderNameTopConst,
                                      leftConstant: newFolderNameSqueezeConst,
                                      bottomConstant: 0,
                                      rightConstant: newFolderNameSqueezeConst,
                                      widthConstant: newFolderNameWidthConst,
                                      heightConstant: newFolderNameHeightConst)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.hasText {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        textField.resignFirstResponder()
        
        self.view.endEditing(true) // Dismiss keyboard
        saveNewFolder()
        return false
    }
    
    func saveNewFolder() {
        // save new Folder Name and make the index of newFolder
        // in gamePlanFolders the folderIndex
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
        
        if newFolderNameTextField.hasText {
            gamePlanFolders[gamePlanIndex].append(newFolderNameTextField.text!)
            folderIndex = gamePlanFolders[gamePlanIndex].count - 1
            var categories = [[[String]]]()
            if let savedCategories = defaults.object(forKey: "allCategories") as? Data {
                categories = NSKeyedUnarchiver.unarchiveObject(with: savedCategories) as! [[[String]]]
            }
            categories[gamePlanIndex].append([String]())
            let saveCategories = NSKeyedArchiver.archivedData(withRootObject: categories)
            defaults.set(saveCategories, forKey: "allCategories")
            
            let saveFolderIndex = NSKeyedArchiver.archivedData(withRootObject: folderIndex)
            let saveGamePlanFolders = NSKeyedArchiver.archivedData(withRootObject: gamePlanFolders)
            defaults.set(saveFolderIndex, forKey: "folderIndex")
            defaults.set(saveGamePlanFolders, forKey: "folders")
            UserDefaults.standard.synchronize()
        }
        
        self.navigationController?.popViewController(animated: true)
        
        //        if (self.navigationController?.topViewController?.isKind(of: NewGamePlanController.self))! {
        //            // If User is coming from newGamePlanController, the app should
        //            // return to OptionsController when the User saves a new game plan
        //            self.navigationController?.popViewController(animated: true)
        //        }
    }
    
    @objc func saveNewFolderName(sender: Any) {
        saveNewFolder()
    }
}













