//
//  UserpostsTableViewCell.swift
//  Zade
//
//  Created by Parth Bhojak on 15/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class UserpostsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var uploadedImage: UIImageView!
    
    
    @IBOutlet weak var uplodedPostdata: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
