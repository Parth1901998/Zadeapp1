//
//  FashionViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 10/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import  GoogleSignIn

class FashionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet weak var fashionTableview: UITableView!
    
    let db = Firestore.firestore()
    
    var blogModel : [FashionModel] = []
    
    
     var headingarray = ["fashion", "fashion", "fashion", "fashion"]
    
    var titlearray = ["Top Trending shoes of all time", "Top Trending handbags of all time","Top Trending white frok of all time","Top Trending blackFrok of all time"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "fashion.png")!,
        UIImage(named: "friends.png")!,
        UIImage(named: "lifestyle.png")!,
        UIImage(named: "travel.png")!
        
    ]
    
    var detailarray = ["vbvqerbveqvneneiqveqveq","fefbvqerbveqvneneiqveqveq","ffgwehnwwtbrw","rfrgevbvqerbveqvneneiqveqveq"]
    
    
    var fashionBlog : [FashionModel] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fashionTableview.delegate = self
        fashionTableview.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(headingarray.count)
        return fashionBlog.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fashioncell", for: indexPath) as! FashionTableViewCell
        cell.fashionImageBlog.image = logoImage[indexPath.row]
        cell.headingBlog.text = headingarray[indexPath.row]
        cell.titleBlog.text = titlearray[indexPath.row]
        cell.descriptionBlog.text = detailarray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func readData() {
   
        self.logoImage.removeAll()
        db.collection("FashionBlogs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = FashionModel()
                    nownewitem.fashionHeading = (document.data()["Heading"] as! String)
                    nownewitem.fashionTitle = (document.data()["Title"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "blogImages/\(nownewitem.fashionimage!).jpg")//document.documentID
                    
                
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.fashionimage  = UIImage(data: data)!
                            self.fashionTableview.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.fashionBlog.append(nownewitem)
                    DispatchQueue.main.async {
                        self.fashionTableview.reloadData()
                        
                    }
                    self.fashionTableview.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
    
}



