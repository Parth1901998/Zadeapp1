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

class FashionViewController: UIViewController{


    @IBOutlet weak var fashionTableview: UITableView!
    
    let db = Firestore.firestore()
    
     var headingarray = ["fashion", "fashion", "fashion", "fashion"]
    

    var logoImage: [UIImage] = [
        UIImage(named: "fashion.png")!,
        UIImage(named: "friends.png")!,
        UIImage(named: "lifestyle.png")!]
    
    var detailarray = ["Top Trending shoes of all time","Top Trending handbags of all time","Top Trending white frok of all time","Trending blackFrok of all time"]
    
    
    var fashionBlog : [FashionModel] = []
    
    
    // MARK:ViewDidload
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fashionBlog = []
         self.readData()
        fashionTableview.reloadData()
        fashionTableview.delegate = self
        fashionTableview.dataSource = self

    }
    
    
    // MARK: Fetch From Firebase

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

                     nownewitem.fashionDescrip = (document.data()["Description"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "blogImages/\(nownewitem.fashionHeading).jpg")//document.documentID
                
                    
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

extension FashionViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return fashionBlog.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fashioncell", for: indexPath) as! FashionTableViewCell
        
    
        cell.fashionImageBlog.image = fashionBlog[indexPath.row].fashionimage
        cell.headingBlog.text = fashionBlog[indexPath.row].fashionHeading
        //        cell.titleBlog.text = fashionBlog[indexPath.row]
        cell.descriptionBlog.text = fashionBlog[indexPath.row].fashionDescrip
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fashionTableview.deselectRow(at: indexPath, animated: true)
    }
    
    
}
