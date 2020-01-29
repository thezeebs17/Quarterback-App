//
//  HarbaughTabBarController.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/2/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

// importing some code from Project Snapper's CustomTabBarController class

import Foundation
import UIKit

class HarbaughTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let resultsVC = UINavigationController(rootViewController: HomeDatasourceController())
//        let ctrlr = CategoriesDatasourceController()
//        let recordView = UINavigationController(rootViewController: ctrlr)
        let recordView = UINavigationController(rootViewController: CategoriesDatasourceController()) // VC for Record
//        let rosterView = UINavigationController(rootViewController: RosterDatasourceController())
//        let resultsView = UINavigationController(rootViewController: ResultsCategoriesDSC())
        
        
        let resultsView = UINavigationController(rootViewController: ResultsCategoriesDSC())
        recordView.tabBarItem.title = "Record"
//        recordView.tabBarItem.image = UITabBarItem(tabBarSystemItem: .bookmarks, tag: <#T##Int#>)
//        rosterView.tabBarItem.title = "Roster"
        resultsView.tabBarItem.title = "Results"
        recordView.tabBarItem.image = #imageLiteral(resourceName: "write_tab_icon")
//        gamePlansView.tabBarItem.image = #imageLiteral(resourceName: "roster_tab_icon")
        resultsView.tabBarItem.image = #imageLiteral(resourceName: "results_tab_icon")
        
        //        let editPlayerView = UINavigationController(rootViewController: RosterEditPlayer())
        //        editPlayerView.tabBarItem.title = "Edit"
        //        editPlayerView.tabBarItem.image = #imageLiteral(resourceName: "roster2_tab_icon")
        
        viewControllers = [recordView/*, gamePlansView*/, resultsView]
        //        viewControllers = [recordView, editPlayerView, resultsVC]
        self.selectedIndex = 0
    }
    
    
    
    
}
