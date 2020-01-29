//
//  ResultsDatasourceController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 9/15/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class ResultsDatasourceController: DatasourceController {
    
    var quarterbacks = [Quarterback]()
    var allCategories = [String]()
    var categoryIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func exportPressed(sender: UIButton) {
        
        let defaults = UserDefaults.standard
        //        if let savedPlayers = defaults.object(forKey: "allPlayers") as? Data {
        //            allPlayers = NSKeyedUnarchiver.unarchiveObject(with: savedPlayers) as! [Player]
        //        }
        
        //        let fileName = "wrResults.csv"
        //        print("DATE:",NSDate().)
        let fileName = "\(allCategories[categoryIndex]).csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = allCategories[categoryIndex] + "\n\n"
        //        var csvText = "Name,DROP,INC,DBL,COM\n"
        csvText.append("Name,DROP,INC,DBL,COM,Ratio\n")
        //        for p in allPlayers {
        for p in quarterbacks {
            let pStr = "#\(p.number) - \(p.name)"
            
            let newLine = pStr /*+ ",\(p.repWRresults["DROP"]!),\(p.repWRresults["INC"]!),\(p.repWRresults["DBL"]!),\(p.repWRresults["COM"]!),\(p.getWRratio())\n"*/
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            vc.excludedActivityTypes = [
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToTwitter,
                UIActivity.ActivityType.postToFacebook,
                
            ]
            
            present(vc, animated: true, completion: nil)
            if let popOver = vc.popoverPresentationController {
                popOver.sourceView = self.view
                //popOver.sourceRect =
                //popOver.barButtonItem
            }
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        
        
    }
    
    
    
    func loadCoreData() {
        let defaults = UserDefaults.standard
        
        if let savedAllCategories = defaults.object(forKey: "allCategories") as? Data {
            allCategories = NSKeyedUnarchiver.unarchiveObject(with: savedAllCategories) as! [String]
        }
        if let savedQuarterbacks = defaults.object(forKey: "quarterbacks") as? Data {
            quarterbacks = NSKeyedUnarchiver.unarchiveObject(with: savedQuarterbacks) as! [Quarterback]
        } else {
            quarterbacks = createQuarterbacks()
        }
    }
}
