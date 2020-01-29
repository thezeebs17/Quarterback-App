//
//  StandardCell.swift
//  Project Harbaugh
//
//  Created by Zeebo Gouldon on 8/4/18.
//  Copyright © 2018 Zeebo Gouldon. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class StandardTableViewCell: UITableViewCell {
    
    var phaseLabel = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //reuseIdentifier = "R_PhaseCell"
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class StandardDatasourceCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let name = datasourceItem as? String else { return }
            nameLabel.text = name
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let nameLabelTopConst: CGFloat = 5
    let nameLabelLeftConst: CGFloat = 10
    let nameLabelWidthConst: CGFloat = 40
    let nameLabelHeightConst: CGFloat = 30
    
    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        backgroundColor = .white
        addSubview(nameLabel)
        nameLabel.anchor(topAnchor,
                         left: leftAnchor,
                         bottom: nil,
                         right: rightAnchor,
                         topConstant: nameLabelTopConst,
                         leftConstant: nameLabelLeftConst,
                         bottomConstant: 0,
                         rightConstant: 0,
                         widthConstant: nameLabelWidthConst,
                         heightConstant: nameLabelHeightConst)
    }
    
    
}







