//
//  CollectionViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 15/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class CollectionViewController: UIViewController {
    

    let db = Firestore.firestore()
    var collectBlog : [CollectModel] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var array = ["Ultra Boosts Shoes", "Star Bags #1", "White Frok", "Black Frok"]
    var arrayPrice = ["$99.69","$99.69","$99.69","$99.69"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "ic_shoes.png")!,
        UIImage(named: "ic_hangbag.png")!,
        UIImage(named: "ic_white.png")!,
        UIImage(named: "ic_black.png")!]
    var image = #imageLiteral(resourceName: "Like")
    
    
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.collectBlog = []
        self.readData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
      
    }
 
    
    //MARK: Fetch From Firebase
    
    func readData()
    {
        self.logoImage.removeAll()
        
        db.collection("newCollection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = CollectModel()
                    nownewitem.collectName = (document.data()["ProductName"] as! String)
                    nownewitem.collectPrice = (document.data()["ProductPrice"] as! String)
                     nownewitem.likeproduct = (document.data()["ProductLike"] as! Bool)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "newCollection/\(nownewitem.collectName).jpg")//document.documentID
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.collectImage  = UIImage(data: data)
                            self.collectionView.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.collectBlog.append(nownewitem)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        
                    }
                    self.collectionView.reloadData()
                   
                }
            }
        }
    }

}

extension CollectionViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectBlog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.collectionName.text = collectBlog[indexPath.row].collectName
        cell.collectionImage.image = collectBlog[indexPath.row].collectImage
        cell.collectionPrice.text = collectBlog[indexPath.row].collectPrice
        
        if collectBlog[indexPath.row].likeproduct == true
        {
          cell.likeCollect.setImage(image, for: .normal)
            
        }
        
        return cell
    }
    
    
}
