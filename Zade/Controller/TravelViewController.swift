//
//  TravelViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase


class TravelViewController: UIViewController{
    
    
    @IBOutlet weak var travelTableView: UITableView!
    
      let db = Firestore.firestore()
       var travelBlog : [TravelModel] = []
    
    let headinglife = [("TravelGoa"),("TravelBali"),("TravelSingapore")]
    var imagesslife = [UIImage(named: "TravelGoa"), UIImage(named: "TravelBali"), UIImage(named: "TravelSingapore")]
    let titlelife = [("friends"),("travel"),("lifestyle")]
    let descriptionlife = [("Travel With your friedns and enjoy your journey"),("travelling gives you the exicitment"),("live your life and enjoy")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readData()
          self.travelBlog = []
        travelTableView.reloadData()
        travelTableView.dataSource = self
        travelTableView.delegate = self

    }
 
     func readData()
      {
        self.imagesslife.removeAll()
        
        db.collection("TravelBlogs").getDocuments() { (querySnapshot, err) in
        if let err = err {
        print("Error getting documents: \(err)")
        
    } else {
            for document in querySnapshot!.documents {
            // most Important
            let nownewitem = TravelModel()
            nownewitem.travelHEading = (document.data()["Heading"] as! String)
            nownewitem.travelDescrip = (document.data()["Description"] as! String)
            // feching data
            let storeRef = Storage.storage().reference(withPath: "travelImages/\(nownewitem.travelHEading).jpg")//document.documentID
        
            storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
            if let error = error {
            print("error-------- \(error.localizedDescription)")
            return
                }
            if let data = data {
            print("Main data\(data)")
            nownewitem.travelimage  = UIImage(data: data)!
                
            self.travelTableView.reloadData()
            }
    })
  
            self.travelBlog.append(nownewitem)
            DispatchQueue.main.async {
            self.travelTableView.reloadData()
    
            }
                self.travelTableView.reloadData()

   
            }
          }
        }
     }
    
}


extension TravelViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelBlog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
        
        cell.travelImage.image = travelBlog[indexPath.row].travelimage
        cell.travelHeading.text = travelBlog[indexPath.row].travelHEading
        //        cell.travelTitle.text = travelBlog[indexPath.row].travelTitle
        cell.travelDesc.text = travelBlog[indexPath.row].travelDescrip
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        travelTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

