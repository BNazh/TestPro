//
//  CustomTableViewCell.swift
//  TestPro
//
//  Created by Nazhmeddin Babakhanov on 21.08.2020.
//  Copyright © 2020 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
