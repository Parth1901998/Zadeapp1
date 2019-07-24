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

class UserPostViewController: UIViewController{
    
    @IBOutlet weak var userPostTableView: UITableView!
    
    @IBOutlet weak var usersImage: UIImageView!
    
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var userSearch: UISearchBar!
    
    
    var postarray = [String]()
    
    
     var posts = [UploadTask]()
    var filterdata = [UploadTask]()
     var inSearchMode = false
    
//    var value = [String]()
    
    var db = Firestore.firestore()
    var post:[String] = []
    //    var postArray = [String: Any]()
    //    let db = Firestore.firestore()
    var index = 0
    var postId = ""
    var uid = ""
    var likess : Int = 0
    



    var userspost = UploadTask()

    var userpostdata  = UserTotalPostModel()
    
    
    
    //MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
          filterdata = posts
        self.posts = []
        self.readData()
        userPostTableView.reloadData()
    }
    
    func getCurrentUser(){
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
            print(uid)
            
        }
    }
    
    @IBOutlet weak var lastSeen: UILabel!
    
    
    
    @IBAction func backToIntroduction(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let IntroductionSlide = storyBoard.instantiateViewController(withIdentifier: "Introduction") as! IntroductionSlide
        self.present(IntroductionSlide, animated:true, completion:nil)
        
    }
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterdata = posts
        
        getCurrentUser()

        userPostTableView.delegate = self
        userPostTableView.dataSource = self
     userPostTableView.reloadData()


    
}
    
    
    //MARK: blog Page
    
    @IBAction func BuyPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let ProductHomeViewController = storyBoard.instantiateViewController(withIdentifier: "ProductHomeViewController") as! ProductHomeViewController
                self.present(ProductHomeViewController, animated:true, completion:nil)
    }
    
    
    //MARK: Fetch From Firebase

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
                    new.useruuid = "\(document.data()["uid"] as! String)"
                    new.count = "\(document.data()["like"] as? String)"
                    new.imagename = "\(document.documentID)"
                    
            
                    let time = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    dateFormatter.doesRelativeDateFormatting = true
                   dateFormatter.string(from: time)
                    
                    dateFormatter.dateFormat = "MMM d, h:mm a"
//                    dateFormatter.dateFormat = "dd. MMMM YYYY\nH:mm:ss"
                
//                    let timeFormatter = ()
//                    dateFormatter.dateStyle = .medium
//                    dateFormatter.doesRelativeDateFormatting = true
                    
                    new.lasttiming = dateFormatter.string(from: ((document.data()["Date"] as? Timestamp)?.dateValue())!) + "," + dateFormatter.string(from: ((document.data()["Date"] as? Timestamp)?.dateValue())!)
                    
                    print(new.lasttiming)

                    
                    new.photourl = "\(document.data()["UserImage"] as! String)"
                    new.usernames = "\(document.data()["UserNames"] as! String)"
                    
                    print(new.photourl)
                    
                    let url = URL(string: new.photourl)
                    
                    print(url!)
                    
                    let data = try? Data(contentsOf: url!)
                     new.userimage = UIImage(data: data!)
                    //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    print(data)
//                    self.usersImage.image = UIImage(data:data!)
             
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).jpg")
                    storageRef.getData(maxSize: 4*1024*1024) { data, error in
                        if let error = error {
                            print("error downloading image:\(error)")
                        } else {
                            // Data for "images/island.jpg" is returned
                            new.image = UIImage(data: data!)
                           
                           
                            self.posts.append(new)
                            self.userPostTableView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
}

extension UserPostViewController : UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filterdata.count
        }
        
            return posts.count
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserpostsTableViewCell", for: indexPath) as! UserpostsTableViewCell
//        let schedule = postarray[indexPath.row]
    
        
//        let text : String!
        
        if inSearchMode
        {
            let inx = filterdata[indexPath.row]
            //         cell.txtView.text = inx.post
            cell.uplodedPostdata.text = inx.post
            cell.uploadedImage.image = inx.image
            cell.userImage.image = inx.userimage
            cell.userName.text = inx.usernames
            cell.usertime.text = inx.lasttiming
        }
        else
        {
        
   let inx = posts[indexPath.row]
        //         cell.txtView.text = inx.post
        cell.uplodedPostdata.text = inx.post
        cell.uploadedImage.image = inx.image
        cell.userImage.image = inx.userimage
        cell.userName.text = inx.usernames
        cell.usertime.text = inx.lasttiming
            
        }
//    getpost()
        return cell
        
    
    }
   
    
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        return 370
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            inSearchMode = false
            filterdata = posts
       userPostTableView.reloadData()
            return
        }
        filterdata = posts.filter({ (UploadTask) -> Bool in
            inSearchMode = true
           return UploadTask.usernames.lowercased().contains(searchText.lowercased())
        })
        userPostTableView.reloadData()
    }
  
    
}


