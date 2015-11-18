//
//  ContentTableViewCell.swift
//  Assignment2_PG
//
//  Created by Sin Hsia Kwok on 8/05/2015.
//  Copyright (c) 2015 Siti Nur Aini Zahari. All rights reserved.
//

import UIKit
import Foundation

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
