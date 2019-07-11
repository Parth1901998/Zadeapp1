//
//  LifeStyleTableViewCell.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class LifeStyleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lifeStylelogimage: UIImageView!
    
    
    @IBOutlet weak var lifestyleHeading: UILabel!
    

    @IBOutlet weak var lifestyleTitle: UILabel!
    
    
    @IBOutlet weak var lifestyleDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
