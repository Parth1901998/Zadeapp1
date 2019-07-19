//
//  newArrivalViewCell.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase

class newArrivalViewCell: UICollectionViewCell {
    
    
  
    let db = Firestore.firestore()
    var arrivalBlog : [NewArriveModel] = []
    
    @IBOutlet weak var newarrivalImage: UIImageView!
    
    @IBOutlet weak var newarrivalName: UILabel!
    
    @IBOutlet weak var newarrivalPrice: UILabel!
    
    @IBOutlet weak var newarrivallike: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
        
        if sender.currentImage == UIImage(named: "ic_heart"){
            
            sender.setImage(UIImage(named: "Like"), for: .normal)
            
            
        }else{
            
            sender.setImage(UIImage(named: "ic_heart"), for: .normal)
        }
        
    }
    
}
