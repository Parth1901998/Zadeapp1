//
//  SideProductsViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 17/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SideProductsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menBlog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SideProducts", for: indexPath) as! SideProductCollectionViewCell
        
        cell.proName.text = menBlog[indexPath.row].mbname
        cell.proImage.image = menBlog[indexPath.row].mbimage
        cell.Pricevalue.text =  menBlog[indexPath.row].mbprice
        return cell
    }
    
    let db = Firestore.firestore()
    var menBlog : [MenModel] = []
    
    
    @IBOutlet weak var sideTableView: UICollectionView!
    
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
        
        
        self.menBlog = []
        sideTableView.dataSource = self
        sideTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func readData()
    {
        self.logoImage.removeAll()
        
        db.collection("MTshirt").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = MenModel()
                    nownewitem.mbname = (document.data()["Brand"] as! String)
                    nownewitem.mbprice = (document.data()["Price"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "MensTshirt/\(nownewitem.mbname).jpg")//document.documentID
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.mbimage  = UIImage(data: data)!
                            self.sideTableView.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.menBlog.append(nownewitem)
                    DispatchQueue.main.async {
                        self.sideTableView.reloadData()
                        
                    }
                    self.sideTableView.reloadData()
                    //        print("Data Print:- \(document.documentID) => \(document.data())")
                    //
                }
            }
        }
    }
    
    

   

}
