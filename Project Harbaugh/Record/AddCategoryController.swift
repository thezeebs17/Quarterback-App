//
//  AddCategoryController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/3/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class AddCategoryController: UIViewController, UITextFieldDelegate {
    
   
    var categories = [String]()
    var catQuarterbacks = [[Quarterback]]()
    var allPlayResults = [[PlayResult]]()
    var undoHistory = [[PlayResult]]()

    // add text field, save Nav Button, save fn,
    
    var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Category Name"
        textField.textAlignment = .center
        textField.autocapitalizationType = .words
        textField.backgroundColor = .yellow
        return textField
    }()
    
    var topConstCategoryTextField: CGFloat = 150
    var leftConstCategoryTextField: CGFloat = -100
    var widthCategoryTextField: CGFloat = 200
    var heightCategoryTextField: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        categoryTextField.delegate = self
        view.backgroundColor = .white
        navigationItem.title = "Add Category"
        setUpNavItems()
        setUpViews()
    }
    
    func setUpNavItems() {
        let saveBtn = UIButton(type: .system)
        saveBtn.setTitle("Save", for: .normal)
        // make font bigger
        //        saveBtn.titleLabel?.font = CGFont(
        saveBtn.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
    }
    
    @objc func savePressed(sender: UIButton) {
        saveCategory()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        textField.resignFirstResponder()
        self.view.endEditing(true) // Dismiss keyboard
        saveCategory()
        return false
    }
    
    private func saveCategory() {
        if categoryTextField.hasText {
            let defaults = UserDefaults.standard
            categories.append(categoryTextField.text!)
            catQuarterbacks.append(createQuarterbacks())
            allPlayResults.append([PlayResult]())
            undoHistory.append([PlayResult]())
//            categoryPlayersList() // gen players list for new cat
            let saveCats = NSKeyedArchiver.archivedData(withRootObject: categories)
            let saveCatQuarterbacks = NSKeyedArchiver.archivedData(withRootObject: catQuarterbacks)
            let savePlayResults = NSKeyedArchiver.archivedData(withRootObject: allPlayResults)
            let saveUndoHistory = NSKeyedArchiver.archivedData(withRootObject: undoHistory)
            defaults.set(saveCats, forKey: "allCategories")
            defaults.set(savePlayResults, forKey: "allPlayResults")
            defaults.set(saveUndoHistory, forKey: "undoHistory")
            defaults.set(saveCatQuarterbacks, forKey: "catQuarterbacks")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
    func setUpViews() {
        view.addSubview(categoryTextField)
        categoryTextField.anchor(view.topAnchor,
                            left: view.centerXAnchor,
                            bottom: nil,
                            right: nil,
                            topConstant: topConstCategoryTextField,
                            leftConstant: leftConstCategoryTextField,
                            bottomConstant: 0,
                            rightConstant: 0,
                            widthConstant: widthCategoryTextField,
                            heightConstant: heightCategoryTextField)
    }
    
    
    
    func loadCoreData() {
        let defaults = UserDefaults.standard
        
        if let savedAllCategories = defaults.object(forKey: "allCategories") as? Data {
            categories = NSKeyedUnarchiver.unarchiveObject(with: savedAllCategories) as! [String]
        }
        if let savedAllPlayResults = defaults.object(forKey: "allPlayResults") as? Data {
            allPlayResults = NSKeyedUnarchiver.unarchiveObject(with: savedAllPlayResults) as! [[PlayResult]]
        }
        if let savedUndoHistory = defaults.object(forKey: "undoHistory") as? Data {
            undoHistory = NSKeyedUnarchiver.unarchiveObject(with: savedUndoHistory) as! [[PlayResult]]
        }
        
    }
    
    
    
    
}




















