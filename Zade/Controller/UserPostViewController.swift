//
//  UserPostViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 15/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class UserPostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var userPostTableView: UITableView!
    
    @IBOutlet weak var usersImage: UIImageView!
    
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var userSearch: UISearchBar!
    
    
    
    var postarray = [String]()
    
    //    var imagepostarray = [String]()
    
    var updatestring : String = ""
    var posts : [UploadTask] = []
    
   
    var db = Firestore.firestore()
    var post:[String] = []
    //    var postArray = [String: Any]()
    //    let db = Firestore.firestore()
    var index = 0
    var postId = ""
    
    
    var userspost = UploadTask()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserpostsTableViewCell", for: indexPath) as! UserpostsTableViewCell
        let schedule = postarray[indexPath.row]
        let inx = posts[indexPath.row]
        //         cell.txtView.text = inx.post
        cell.uplodedPostdata.text = schedule
        cell.uploadedImage.image = inx.image
        getpost()
        return cell
    }
    

//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        let heightOfRow = self.calculateHeight(inString :postarray[indexPath.row])
        //        return (heightOfRow + 50)
        return 300
        
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.posts = []
        self.readData()
        userPostTableView.reloadData()
        
    }
    
    
    
    @IBOutlet weak var lastSeen: UILabel!
    
    
    @IBAction func backToIntroduction(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let IntroductionSlide = storyBoard.instantiateViewController(withIdentifier: "Introduction") as! IntroductionSlide
        self.present(IntroductionSlide, animated:true, completion:nil)
        
    }
    
    
    func getpost()
    {
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.postarray.append(document.data()["postdata"] as! String)
                    print(document)
                    print(self.postarray)
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        userPostTableView.delegate = self
        userPostTableView.dataSource = self
        
        let user = Auth.auth().currentUser
        userName.text = user?.displayName
        let url = user?.photoURL
        
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            usersImage.image = image
            usersImage.layer.borderWidth = 1
            usersImage.layer.masksToBounds = false
            usersImage.layer.borderColor = UIColor.black.cgColor
            usersImage.layer.cornerRadius = usersImage.frame.height/2
            usersImage.clipsToBounds = true
        let db = Firestore.firestore()
      getpost()
        
    }
}
    
    @IBAction func BuyPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let ProductHomeViewController = storyBoard.instantiateViewController(withIdentifier: "ProductHomeViewController") as! ProductHomeViewController
                self.present(ProductHomeViewController, animated:true, completion:nil)
    }
    

    func readData() {
        db = Firestore.firestore()
        posts = []
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let new = UploadTask()
                    new.post = "\(document.data()["postdata"] as! String)"
                    new.imagename = "\(document.documentID)"
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).jpg")
                    storageRef.getData(maxSize: 4*1024*1024) { data, error in
                        if let error = error {
                            print("error downloading image:\(error)")
                        } else {
                            // Data for "images/island.jpg" is returned
                            new.image = UIImage(data: data!)
                            //                            self.posts.append(new)
                            //                            self.tableview.reloadData()
                            self.posts.append(new)
                            self.userPostTableView.reloadData()
                        }
                    }
                    
                    
                }
            }
        }
        
    }

}