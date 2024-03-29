//
//  LifeStyleViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class LifeStyleViewController: UIViewController{
    
    let db = Firestore.firestore()
    
      var blogModel : [LifeStyleModel] = []
    
    @IBOutlet weak var lifestyleTableView: UITableView!
    
    
    var logoImage: [UIImage] = [
        UIImage(named: "fashion.png")!,
        UIImage(named: "friends.png")!,
        UIImage(named: "lifestyle.png")!,
        UIImage(named: "travel.png")!]
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        self.blogModel = []
        self.readData()
          lifestyleTableView.reloadData()
        lifestyleTableView.delegate = self
        lifestyleTableView.dataSource = self

    }

    // MARK: Fetch From Firebase
   
    func readData() {
    
        self.logoImage.removeAll()
        
        db.collection("LifeStyleBlogs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = LifeStyleModel()
                    nownewitem.blogHeadings = (document.data()["Heading"] as! String)

                    nownewitem.blogDescription = (document.data()["Description"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "lifestyleImages/\(nownewitem.blogHeadings).jpg")//document.documentID
                    

                    
                    storeRef.getData(maxSize: 4 * 1024 *  1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.blogimage  = UIImage(data: data)!
                            self.lifestyleTableView.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.blogModel.append(nownewitem)
                    DispatchQueue.main.async {
                        self.lifestyleTableView.reloadData()
                        
                    }
                    self.lifestyleTableView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    
    }
}


extension LifeStyleViewController : UITableViewDataSource,UITableViewDelegate{
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeStyle", for: indexPath) as! LifeStyleTableViewCell
        
        
        let lifeModel = blogModel[indexPath.row]
        
        cell.lifeStylelogimage.image = blogModel[indexPath.row].blogimage
        
        cell.lifestyleHeading.text = blogModel[indexPath.row].blogHeadings
        
        cell.lifestyleDesc.text = blogModel[indexPath.row].blogDescription
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lifestyleTableView.deselectRow(at: indexPath, animated: true)
    }

}
