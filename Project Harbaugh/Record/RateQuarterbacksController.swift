//
//  ViewController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/2/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import UIKit

class RateQuarterbacksController: UIViewController {
    
    var allPlayResults = [[PlayResult]]()
    var undoHistory = [[PlayResult]]()
    var catQuarterbacks = [[Quarterback]]()
    var quarterbackIndex = Int()
    var categoryIndex = Int()
    
    var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESET", for: .normal)
        
        button.backgroundColor = UIColor(r: 20, g: 150, b: 20)
        button.tintColor = .white
        button.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        return button
    }()
    
    var poorRatingSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "POOR THROW", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "POOR READ", at: 0, animated: true)
        segmentedControl.addTarget(self, action: #selector(poorRatingValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = -1
        segmentedControl.tintColor = .red
        return segmentedControl
    }()
    
    var catchRatingSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "EXP", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "INT", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "DROP", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "INC", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "COM", at: 0, animated: true)
        segmentedControl.addTarget(self, action: #selector(catchRatingValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    var withPressureSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "PRESSURE", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "NO PRESS.", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "N/A", at: 0, animated: true)
        segmentedControl.addTarget(self, action: #selector(withPressureValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    
    @objc func poorRatingValueChanged(sender: UISegmentedControl) {
        
    }
    
    @objc func catchRatingValueChanged(sender: UISegmentedControl) {
       
    }
    
    @objc func withPressureValueChanged(sender: UISegmentedControl) {
        
    }
    
    let snapButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.titleLabel?.text = "SNAP!"
        button.setTitle("SNAP!", for: .normal)
        button.tintColor = .white // think "title color" (but it tech'ly isn't)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(snapPressed), for: .touchUpInside)
        return button
    }()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.titleLabel?.text = "SNAP!"
        button.setTitle("UNDO", for: .normal)
        button.tintColor = .white // think "title color" (but it tech'ly isn't)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(undoPressed), for: .touchUpInside)
        return button
    }()
    
    let redoButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.titleLabel?.text = "SNAP!"
        button.setTitle("REDO", for: .normal)
        button.tintColor = .white // think "title color" (but it tech'ly isn't)
        button.backgroundColor = UIColor(r: 10, g: 220, b: 10)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(redoPressed), for: .touchUpInside)
        return button
    }()
    
    let commentsTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        textView.text = "Comments"
        textView.textColor = .lightGray
        textView.font = UIFont(name: textView.font?.fontName as! String, size: 14)
        return textView
    }()
    
    let snapCountLabel: UILabel = {
        let label = getGrayUILabel(text: "##")
        label.textAlignment = .center
        return label
    }()
    
    let snapCountPlayerLabel: UILabel = {
        let label = getGrayUILabel(text: "##")
        label.backgroundColor = .magenta
        return label
    }()
    
    @objc func resetTapped(sender: UIButton) {
        resetUIFeatures()
    }
    
    func resetUIFeatures() {
        poorRatingSegmentedControl.selectedSegmentIndex = -1
        catchRatingSegmentedControl.selectedSegmentIndex = -1
    }
    
    @objc func snapPressed(sender: Any) {
        // playResult stuff
        undoHistory[categoryIndex] = [PlayResult]()
        var newPoorPassRating: String = "/"
        var newCatchRating: String = "/"
        var newWithPressureRating: String = "/"
        let quarterbackName = catQuarterbacks[categoryIndex][quarterbackIndex].name
        let quarterbackNumber = catQuarterbacks[categoryIndex][quarterbackIndex].number
        
        
        if poorRatingSegmentedControl.selectedSegmentIndex != -1 {
            newPoorPassRating = poorRatingSegmentedControl.titleForSegment(at: poorRatingSegmentedControl.selectedSegmentIndex) as! String
        }
        if catchRatingSegmentedControl.selectedSegmentIndex != -1 {
            newCatchRating = catchRatingSegmentedControl.titleForSegment(at: catchRatingSegmentedControl.selectedSegmentIndex) as! String
        }
        
        // catRunningBack stuff
        if poorRatingSegmentedControl.selectedSegmentIndex == 0 {
            catQuarterbacks[categoryIndex][quarterbackIndex].poorReadCount += 1
        } else if poorRatingSegmentedControl.selectedSegmentIndex == 1 {
            catQuarterbacks[categoryIndex][quarterbackIndex].poorThrowCount += 1
        }
        if catchRatingSegmentedControl.selectedSegmentIndex == 0 { // COM
            catQuarterbacks[categoryIndex][quarterbackIndex].completionCount += 1
            catQuarterbacks[categoryIndex][quarterbackIndex].attemptCount += 1
        } else if catchRatingSegmentedControl.selectedSegmentIndex == 1 { // DROP
            catQuarterbacks[categoryIndex][quarterbackIndex].incompletionCount += 1
            catQuarterbacks[categoryIndex][quarterbackIndex].attemptCount += 1
        } else if catchRatingSegmentedControl.selectedSegmentIndex == 2 { // DROP
            catQuarterbacks[categoryIndex][quarterbackIndex].dropCount += 1
            catQuarterbacks[categoryIndex][quarterbackIndex].attemptCount += 1
        } else if catchRatingSegmentedControl.selectedSegmentIndex == 3 { // INT
            catQuarterbacks[categoryIndex][quarterbackIndex].interceptionCount += 1
            catQuarterbacks[categoryIndex][quarterbackIndex].attemptCount += 1
        } else if catchRatingSegmentedControl.selectedSegmentIndex == 4 { // EXP
            catQuarterbacks[categoryIndex][quarterbackIndex].explosiveCount += 1
            catQuarterbacks[categoryIndex][quarterbackIndex].attemptCount += 1
        }
        
        let newPlayResult = PlayResult(newQuarterbackName: quarterbackName,
                                       newQuarterbackNumber: quarterbackNumber,
                                       newQuarterbackIndex: quarterbackIndex,
                                       newPlayCount: String(allPlayResults[categoryIndex].count + 1),
                                       newCatchRating: newCatchRating,
                                       newPoorPassRating: newPoorPassRating,
                                       newWithPressureRating: newWithPressureRating)
        allPlayResults[categoryIndex].append(newPlayResult)
        print("# \(newPlayResult.quarterbackNumber) \(newPlayResult.quarterbackName) | \(newPlayResult.playCount) | \(newPlayResult.catchRating) | \(newPlayResult.poorPassRating) | \(newPlayResult.withPressureRating)")
        let defaults = UserDefaults.standard
        let saveCatQuarterbacks = NSKeyedArchiver.archivedData(withRootObject: catQuarterbacks)
        let savePlayResults = NSKeyedArchiver.archivedData(withRootObject: allPlayResults)
        defaults.set(savePlayResults, forKey: "allPlayResults")
        defaults.set(saveCatQuarterbacks, forKey: "catQuarterbacks")
        resetUIFeatures()
        updateSnapLabels()
    }
    
    @objc func undoPressed(sender: UIButton) {
        
        // pop off the most recently saved playResult from allPlayResults core data
        // array, and store it in undoHistory.
        // Also, be sure to go to the appropriate runningBack in catRunningBacks
        // and "untally" the appropriate categories and yards ran, etc.
        if !(allPlayResults[categoryIndex].isEmpty) {
            let undoPlayResult = allPlayResults[categoryIndex][allPlayResults[categoryIndex].count-1]
            // playResult stuff
            
            // catQuarterback stuff
            let undoQuarterbackIndex = undoPlayResult.quarterbackIndex
            if undoPlayResult.catchRating != "/" {
                if undoPlayResult.catchRating == "COM" {
                    catQuarterbacks[categoryIndex][undoQuarterbackIndex].completionCount -= 1
                }
                if undoPlayResult.catchRating == "INT" {
                    catQuarterbacks[categoryIndex][undoQuarterbackIndex].interceptionCount -= 1
                }
                if undoPlayResult.catchRating == "INC" {
                    
                }
            }
            
            undoHistory[categoryIndex].append(undoPlayResult)
            allPlayResults[categoryIndex].remove(at: allPlayResults[categoryIndex].count-1)
            let defaults = UserDefaults.standard
            let saveCatQuarterbacks = NSKeyedArchiver.archivedData(withRootObject: catQuarterbacks)
            let saveUndoHistory = NSKeyedArchiver.archivedData(withRootObject: undoHistory)
            let savePlayResults = NSKeyedArchiver.archivedData(withRootObject: allPlayResults)
            defaults.set(saveCatQuarterbacks, forKey: "catRunningBacks")
            defaults.set(saveUndoHistory, forKey: "undoHistory")
            defaults.set(savePlayResults, forKey: "allPlayResults")
            updateSnapLabels()
            hideOrShowRedoButton(hide: false)
        }
        
    }
    
    @objc func redoPressed(sender: UIButton) {
        // From undoHistory, find the recently used running back
        // and re-add in whatever results were made into the count for
        // that running back
        // and also add back in this playResult from undoHistory into
        // the allPlayResults core data array.
        if !(undoHistory[categoryIndex].isEmpty) {
            // playResult stuff
            let redoPlayResult = undoHistory[categoryIndex][undoHistory[categoryIndex].count-1]
            // catQuarterbacks stuff
            
            allPlayResults[categoryIndex].append(redoPlayResult)
            undoHistory[categoryIndex].remove(at: undoHistory[categoryIndex].count-1)
            let defaults = UserDefaults.standard
            let saveCatQuarterbacks = NSKeyedArchiver.archivedData(withRootObject: catQuarterbacks)
            let saveUndoHistory = NSKeyedArchiver.archivedData(withRootObject: undoHistory)
            let savePlayResults = NSKeyedArchiver.archivedData(withRootObject: allPlayResults)
            defaults.set(saveCatQuarterbacks, forKey: "catQuarterbacks")
            defaults.set(saveUndoHistory, forKey: "undoHistory")
            defaults.set(savePlayResults, forKey: "allPlayResults")
            updateSnapLabels()
            hideOrShowRedoButton(hide: false)
        }
        updateSnapLabels()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .white
        loadCoreData()
        updateSnapLabels()
        setUpNavItems()
        setUpViews()
        
    }
    
    func loadCoreData() {
        let defaults = UserDefaults.standard
        if let savedCatQuarterbacks = defaults.object(forKey: "catQuarterbacks") as? Data {
            catQuarterbacks = NSKeyedUnarchiver.unarchiveObject(with: savedCatQuarterbacks) as! [[Quarterback]]
        }
        if let savedAllPlayResults = defaults.object(forKey: "allPlayResults") as? Data {
            allPlayResults = NSKeyedUnarchiver.unarchiveObject(with: savedAllPlayResults) as! [[PlayResult]]
        }
        if let savedUndoHistory = defaults.object(forKey: "undoHistory") as? Data {
            undoHistory = NSKeyedUnarchiver.unarchiveObject(with: savedUndoHistory) as! [[PlayResult]]
        }
        
    }
    
    private func setUpNavItems() {
        //        let addCategoryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategoryButtonPressed))
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
//
//        let addButton = UIButton(type: .system)
//        addButton.setTitle("Options", for: .normal)
//        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
//        //        navigationItem.setRightBarButton(addCategoryButton, animated: true)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    private func updateSnapLabels() {
        snapCountLabel.text = "\(allPlayResults[categoryIndex].count)"
        if undoHistory[categoryIndex].count != 0 {
            hideOrShowRedoButton(hide: false)
        } else {
            hideOrShowRedoButton(hide: true)
        }
        if allPlayResults[categoryIndex].count != 0 {
            hideOrShowUndoButton(hide: false)
        } else {
            hideOrShowUndoButton(hide: true)
        }
    }
    
    func hideOrShowRedoButton(hide: Bool) {
        if hide {
            redoButton.isHidden = true
        } else {
            redoButton.isHidden = false
        }
    }
    
    func hideOrShowUndoButton(hide: Bool) {
        if hide {
            undoButton.isHidden = true
        } else {
            undoButton.isHidden = false
        }
    }

    @objc func addTapped(sender: UIButton) {
        let segueAddButton = AddCategoryController()
        navigationController?.pushViewController(segueAddButton, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let resetButtonTopConst: CGFloat = 80
    let buttonWidthConst: CGFloat = 100
    let poorRatingSegmentedControlTopConst: CGFloat = 30
    let catchRatingSegmentedControlTopConst: CGFloat = 20
    let segmentedControlGapConst: CGFloat = 10
    let poorSegmentedControlGapConst: CGFloat = 40
    let segmentedControlWidthConst: CGFloat = 200
    let catchRatingSegmentedControlWidthConst: CGFloat = 260
    let segmentedControlHeightConst: CGFloat = 35

    var snapButtonWidthConst: CGFloat = 84
    var snapButtonHeightConst: CGFloat = 45
    
    var undoRedoGapConst: CGFloat = 14
    
    func setUpViews() {
        
        view.addSubview(resetButton)
        resetButton.anchor(view.topAnchor,
                           left: view.centerXAnchor,
                           bottom: nil,
                           right: nil,
                           topConstant: resetButtonTopConst,
                           leftConstant: buttonWidthConst / 2 * -1,
                           bottomConstant: 0,
                           rightConstant: 0,
                           widthConstant: buttonWidthConst,
                           heightConstant: segmentedControlHeightConst)
        view.addSubview(poorRatingSegmentedControl)
        poorRatingSegmentedControl.anchor(resetButton.bottomAnchor,
                                           left: view.centerXAnchor,
                                           bottom: nil,
                                           right: nil,
                                           topConstant: poorRatingSegmentedControlTopConst,
                                           leftConstant: segmentedControlWidthConst * -1 / 2,
                                           bottomConstant: 0,
                                           rightConstant: poorSegmentedControlGapConst,
                                           widthConstant: segmentedControlWidthConst,
                                           heightConstant: segmentedControlHeightConst)
        view.addSubview(catchRatingSegmentedControl)
        catchRatingSegmentedControl.anchor(poorRatingSegmentedControl.bottomAnchor,
                                           left: view.centerXAnchor,
                                           bottom: nil,
                                           right: nil,
                                           topConstant: catchRatingSegmentedControlTopConst,
                                           leftConstant: catchRatingSegmentedControlWidthConst * -1 / 2,
                                           bottomConstant: 0,
                                           rightConstant: segmentedControlGapConst,
                                           widthConstant: catchRatingSegmentedControlWidthConst,
                                           heightConstant: segmentedControlHeightConst)
        
        view.addSubview(withPressureSegmentedControl)
        withPressureSegmentedControl.anchor(catchRatingSegmentedControl.bottomAnchor,
                          left: view.centerXAnchor,
                          bottom: nil,
                          right: nil,
                          topConstant: catchRatingSegmentedControlTopConst + 20,
                          leftConstant: catchRatingSegmentedControlWidthConst * -1 / 2,
                          bottomConstant: 0,
                          rightConstant: segmentedControlGapConst,
                          widthConstant: catchRatingSegmentedControlWidthConst,
                          heightConstant: segmentedControlHeightConst)
        
        
        
        view.addSubview(snapButton)
        snapButton.anchor(withPressureSegmentedControl.bottomAnchor,
                           left: view.centerXAnchor,
                           bottom: nil,
                           right: nil,
                           topConstant: catchRatingSegmentedControlTopConst + 20,
                           leftConstant: buttonWidthConst * -1 / 2,
                           bottomConstant: 0,
                           rightConstant: segmentedControlGapConst,
                           widthConstant: buttonWidthConst,
                           heightConstant: segmentedControlHeightConst + 10)
        view.addSubview(snapCountLabel)
        snapCountLabel.anchor(snapButton.bottomAnchor,
                              left: view.centerXAnchor,
                              bottom: nil,
                              right: nil,
                              topConstant: 3,
                              leftConstant: 20 * -1 / 2,
                              bottomConstant: 0,
                              rightConstant: 0,
                              widthConstant: 20,
                              heightConstant: 15)
        
        view.addSubview(undoButton)
        undoButton.anchor(snapButton.topAnchor,
                          left: nil,
                          bottom: nil,
                          right: snapButton.leftAnchor,
                          topConstant: 0,
                          leftConstant: 0,
                          bottomConstant: 0,
                          rightConstant: undoRedoGapConst,
                          widthConstant: snapButtonWidthConst - 16,
                          heightConstant: snapButtonHeightConst - 10)
        
        view.addSubview(redoButton)
        redoButton.anchor(snapButton.topAnchor,
                          left: snapButton.rightAnchor,
                          bottom: nil,
                          right: nil,
                          topConstant: 0,
                          leftConstant: undoRedoGapConst,
                          bottomConstant: 0,
                          rightConstant: 0,
                          widthConstant: snapButtonWidthConst - 16,
                          heightConstant: snapButtonHeightConst - 10)
    }

}












