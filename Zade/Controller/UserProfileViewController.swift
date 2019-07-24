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

class UserProfileViewController: UIViewController{
    

    let db = Firestore.firestore()
    var allImages : [UserTotalPostModel] = []
    
    var logoImage: [UIImage] = [
        UIImage(named: "ic_shoes.png")!,
        UIImage(named: "ic_hangbag.png")!,
        UIImage(named: "ic_white.png")!,
        UIImage(named: "ic_black.png")!]


    @IBOutlet weak var userproname: UILabel!
    
    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var userUploadedPhotos: UICollectionView!
    
    
    @IBOutlet weak var folow: UIButton!
    
    @IBAction func followPressed(_ sender: UIButton) {
 
    folow.setTitle("Following", for: .normal)
 
    
    }
    
    
 
    @IBAction func backToSide(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        folow.layer.borderColor = UIColor(red: 153/255, green: 206/255, blue: 102/255, alpha:1).cgColor
        folow.layer.borderWidth = 1
        folow.layer.cornerRadius = 24
        folow.clipsToBounds = true
        
        
        self.allImages = []
        self.readData()
        
        userUploadedPhotos.reloadData()
        
        userUploadedPhotos.dataSource = self
        userUploadedPhotos.delegate = self
        
        let user = Auth.auth().currentUser
        userproname.text = user?.displayName
        let url = user?.photoURL
        
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            userimage.image = image
            
            userimage.layer.borderWidth = 1
            userimage.layer.masksToBounds = false
            userimage.layer.borderColor = UIColor.black.cgColor
            userimage.layer.cornerRadius = userimage.frame.height/2
            userimage.clipsToBounds = true
        }
        
    }
    
    // MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.allImages = []
        self.readData()
        userUploadedPhotos.reloadData()
    }
    
    
    // MARK: Fech From Firebase

    func readData() {
       let db = Firestore.firestore()
        allImages = []
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let new = UserTotalPostModel()
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).jpg")
                    storageRef.getData(maxSize: 4*1024*1024) { data, error in
                        if let error = error {
                            print("error downloading image:\(error)")
                        } else {
                        
                            new.allPhotos = UIImage(data: data!)
                            self.allImages.append(new)
                            self.userUploadedPhotos.reloadData()
                        }
                    }
                    
                    
                }
            }
        }
        
    }
}

extension UserProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userprofiles", for: indexPath) as! UserupdatesCollectionViewCell
        cell.uploadedImage.image = allImages[indexPath.row].allPhotos
        return cell
    }
}
