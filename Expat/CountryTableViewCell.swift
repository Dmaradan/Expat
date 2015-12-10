//
//  CountryTableViewCell.swift
//  Expat
//
//  Created by Diego Martin on 12/8/15.
//  Copyright © 2015 Diego Martin. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
