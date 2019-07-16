//
//  NewArrivals.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase

class NewArrivals: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return arrivalBlog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newArrivalViewCell", for: indexPath) as! newArrivalViewCell
        cell.newarrivalName.text = arrivalBlog[indexPath.row].newarriveName
        cell.newarrivalImage.image=arrivalBlog[indexPath.row].newarrriveImage
        cell.newarrivalPrice.text=arrivalBlog[indexPath.row].newarrivePrice
        return cell
    }
      let db = Firestore.firestore()
    var arrivalBlog : [NewArriveModel] = []
    
    @IBOutlet weak var newArrivalCollection: UICollectionView!
    
    var array = ["Ultra Boosts Shoes", "Star Bags #1", "White Frok", "Black Frok"]
    var arrayPrice = ["$99.69","$99.69","$99.69","$99.69"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "ic_shoes.png")!,
        UIImage(named: "ic_hangbag.png")!,
        UIImage(named: "ic_white.png")!,
        UIImage(named: "ic_black.png")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readData()
       
        
        self.arrivalBlog = []
        newArrivalCollection.dataSource = self
        newArrivalCollection.delegate = self
        
    }
  
    
    func readData()
    {
        self.logoImage.removeAll()
        
        db.collection("newArrivals").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = NewArriveModel()
                    nownewitem.newarriveName = (document.data()["ProductName"] as! String)
                    nownewitem.newarrivePrice = (document.data()["ProductPrice"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "newArrivals/\(nownewitem.newarriveName).png")//document.documentID
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.newarrriveImage  = UIImage(data: data)!
                            self.newArrivalCollection.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.arrivalBlog.append(nownewitem)
                    DispatchQueue.main.async {
                        self.newArrivalCollection.reloadData()
                        
                    }
                    self.newArrivalCollection.reloadData()
                    //        print("Data Print:- \(document.documentID) => \(document.data())")
                    //
                }
            }
        }
    }


}
