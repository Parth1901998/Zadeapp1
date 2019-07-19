//
//  UserpostsTableViewCell.swift
//  Zade
//
//  Created by Parth Bhojak on 15/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class UserpostsTableViewCell: UITableViewCell {
    
    let db = Firestore.firestore()
    
  var userPage : [UploadTask] = []
    
    var uid = ""
    var counter = 0
    
    @IBOutlet weak var uploadedImage: UIImageView!
    
    
    @IBOutlet weak var uplodedPostdata: UILabel!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var usertime: UILabel!
    
    
    @IBOutlet weak var likeHere: UIButton!
    
    @IBOutlet weak var labelLike: UILabel!
    
    
    
    @IBAction func comment(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func like(_ sender: UIButton) {
        
        
        if sender.isSelected {
                counter = counter - 1
           labelLike.text =  "\(counter)"
            
            // It will be deselected and count decreased by 1
        } else {
                counter = (counter + 1)
         labelLike.text = "\(counter)"   // It will be selected and count increased by 1
        
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        uploadedImage.layer.cornerRadius = uploadedImage.frame.height/2
        
       
        getCurrentUser()
        
        let user = Auth.auth().currentUser
        userName.text = user?.displayName
        let url = user?.photoURL

        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            userImage.image = image
            userImage.layer.borderWidth = 1
            userImage.layer.masksToBounds = false
            userImage.layer.borderColor = UIColor.black.cgColor
            userImage.layer.cornerRadius = userImage.frame.height/2
            userImage.clipsToBounds = true
        
        // Initialization code
    }
        
        
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getCurrentUser(){
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
            print(uid)
            
        }
    }
    
 
    
        


}
