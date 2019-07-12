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

class UserProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    


    @IBOutlet weak var userproname: UILabel!
    
    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var userUploadedPhotos: UICollectionView!
    
    
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
