//
//  CategoryCell.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/3/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class CategoryCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            
            guard let categoryName = datasourceItem as? String else { return }
            categoryNameLabel.text = categoryName
        }
    }
    
    var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.backgroundColor = .green
        return label
    }()
    
    let categoryNameLabelGapConst: CGFloat = 10
    let categoryNameLabelWidthConst: CGFloat = 70
    let categoryNameLabelHeightConst: CGFloat = 30
    
    
    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 200, g: 200, b: 200)
        addSubview(categoryNameLabel)
        
        categoryNameLabel.anchor(centerYAnchor,
                                 left: leftAnchor,
                                 bottom: nil,
                                 right: rightAnchor,
                                 topConstant: categoryNameLabelHeightConst / 2 * -1,
                                 leftConstant: categoryNameLabelGapConst,
                                 bottomConstant: 0,
                                 rightConstant: 0,
                                 widthConstant: categoryNameLabelWidthConst,
                                 heightConstant: categoryNameLabelHeightConst)
    }
    
}












