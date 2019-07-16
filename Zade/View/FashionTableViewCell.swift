//
//  FashionTableViewCell.swift
//  Zade
//
//  Created by Parth Bhojak on 10/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class FashionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fashionImageBlog: UIImageView!
    
    
    @IBOutlet weak var headingBlog: UILabel!
    
    
    @IBOutlet weak var descriptionBlog: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
