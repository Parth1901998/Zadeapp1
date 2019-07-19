//
//  BestSellersViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 15/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class BestSellersViewController: UIViewController{
    

    let db = Firestore.firestore()
    var sellerBlog : [BestSellerModel] = []
    
    @IBOutlet weak var BestSellerView: UICollectionView!
    
    
    var array = ["Ultra Boosts Shoes", "Star Bags #1", "White Frok", "Black Frok"]
    var arrayPrice = ["$99.69","$99.69","$99.69","$99.69"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "ic_shoes.png")!,
        UIImage(named: "ic_hangbag.png")!,
        UIImage(named: "ic_white.png")!,
        UIImage(named: "ic_black.png")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//                let itemSize = UIScreen.main.bounds.width / 2 - 10
//        
//                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                layout.sectionInset = UIEdgeInsets(top: 20, left: 2, bottom: 10, right: 2)
//                layout.minimumInteritemSpacing = 10
//                layout.minimumLineSpacing = 10
//                layout.itemSize = CGSize(width: itemSize, height: itemSize + 50)
//                BestSellerView!.collectionViewLayout = layout
        
        self.sellerBlog = []
        self.readData()
        BestSellerView.reloadData()
        BestSellerView.delegate = self
        BestSellerView.dataSource = self

    }
    
   
    func readData()
    {
        self.logoImage.removeAll()
        
        db.collection("bestSellers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = BestSellerModel()
                    nownewitem.bestName = (document.data()["Heading"] as! String)
                 
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "bestSellers/\(nownewitem.bestName).jpg")//document.documentID
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.bestImage  = UIImage(data: data)!
                            self.BestSellerView.reloadData()
                        }
                    })
             
                    self.sellerBlog.append(nownewitem)
                    DispatchQueue.main.async {
                        self.BestSellerView.reloadData()
                        
                    }
                    self.BestSellerView.reloadData()
                   
                }
            }
        }
    }
  

}

extension BestSellersViewController :UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sellerBlog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestSeller", for: indexPath) as! BestSellerCollectionViewCell
        cell.sellerImages.image = sellerBlog[indexPath.row].bestImage
        cell.sellerName.text = sellerBlog[indexPath.row].bestName
        return cell
    }
}
