//
//  BlogModel.swift
//  Zade
//
//  Created by Parth Bhojak on 10/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class BlogModel
{
    var fashionimage : UIImage?
    var fashionheading : String?
    var fashiontitle : String?
    var fashiondescription : String?
    
    init(fashionimage:UIImage?, fashionheading : String?,fashiontitle : String?,fashiondescription:String?){
        self.fashionimage = fashionimage
        self.fashionheading = fashionheading
        self.fashiontitle = fashiontitle
        self.fashiondescription = fashiondescription
        
    }
}

