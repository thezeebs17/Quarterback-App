//
//  SelectQuarterbacksTableViewController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/5/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class SelectQuarterbackDatasourceController: DatasourceController {
    
    var categoryIndex = Int()
    
//    var quarterbacks = [Quarterback]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = " rewagre"
        loadCoreData()
        var selectQuarterbackDS = SelectQuarterbacksDatasource()
        selectQuarterbackDS.categoryIndex = self.categoryIndex
        self.datasource = selectQuarterbackDS
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let segueRateQuarterback = RateQuarterbacksController()
        segueRateQuarterback.quarterbackIndex = indexPath.row
        segueRateQuarterback.categoryIndex = categoryIndex
        let selectedQuarterback = self.datasource?.item(indexPath) as! Quarterback
        segueRateQuarterback.navigationItem.title = selectedQuarterback.name
        navigationController?.pushViewController(segueRateQuarterback, animated: true)
    }
    
    func loadCoreData() {
        
//        if let savedQuarterbacks = defaults.object(forKey: "quarterbacks") as? Data {
//            quarterbacks = NSKeyedUnarchiver.unarchiveObject(with: savedQuarterbacks) as! [Quarterback]
//        } else {
//            createQuarterbacks()
//        }
        
    }
}
















