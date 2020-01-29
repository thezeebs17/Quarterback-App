//
//  GlobalMethods.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 11/23/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit


func getGrayUILabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.adjustsFontSizeToFitWidth = true
    label.textColor = .gray
    //label.backgroundColor = .cyan
    
    return label
}

