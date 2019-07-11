//
//  TravelTableViewCell.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var travellogimage: UIImageView!
    

    
    @IBOutlet weak var travelHeading: UILabel!
    
    
    @IBOutlet weak var travelTitle: UILabel!
    
    @IBOutlet weak var travelDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
