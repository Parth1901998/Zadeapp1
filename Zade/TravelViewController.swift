//
//  TravelViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase


class TravelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelBlog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Travel", for: indexPath) as! TravelTableViewCell
        
        cell.travellogimage.image = self.imagesslife[indexPath.row]
        cell.travelHeading.text = self.headinglife[indexPath.row]
        cell.travelTitle.text = self.titlelife[indexPath.row]
        cell.travelDesc.text = self.descriptionlife[indexPath.row]
     

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    @IBOutlet weak var travelTableView: UITableView!
    
      let db = Firestore.firestore()
       var travelBlog : [TravelModel] = []
    
    let headinglife = [("friends"),("travel"),("lifestyle"),("fashion"),("lifestyleblog")]
    var imagesslife = [UIImage(named: "friends"), UIImage(named: "travel"), UIImage(named: "lifestyle"), UIImage(named: "fashion"), UIImage(named: "lifestyleblog")]
    let titlelife = [("friends"),("travel"),("lifestyle"),("fashion"),("lifestyleblog")]
    let descriptionlife = [("Travel With your friedns and enjoy your journey"),("travelling gives you the exicitment"),("live your life and enjoy"),("fashion is the key point of human life"),("post your daily life style in a blog")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        travelTableView.dataSource = self
        travelTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.travelBlog = []
        self.readData()
        travelTableView.reloadData()
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
            nownewitem.travelTitle = (document.data()["Title"] as! String)
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
    //self.nows.append(nownewitem.image!)
            self.travelBlog.append(nownewitem)
            DispatchQueue.main.async {
            self.travelTableView.reloadData()
    
            }
                self.travelTableView.reloadData()
//        print("Data Print:- \(document.documentID) => \(document.data())")
//    
            }
            }
        }
    }

}
