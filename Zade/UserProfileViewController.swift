//
//  UserProfileViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 10/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import  Firebase
import FirebaseAuth

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userproname: UILabel!
    
    @IBOutlet weak var userimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        userproname.text = user?.displayName
        let url = user?.photoURL
        
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            userimage.image = image
        }
        
    }
}
