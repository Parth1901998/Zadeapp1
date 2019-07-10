//
//  ContentVC.swift
//  Zade
//
//  Created by Parth Bhojak on 09/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class ContentVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionData: UICollectionView!
    
    var array = ["Ultra Boosts Shoes", "Star Bags #1", "White Frok", "Black Frok"]
    var arrayPrice = ["$99.69","$99.69","$99.69","$99.69"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "ic_shoes.png")!,
        UIImage(named: "ic_handbag.png")!,
        UIImage(named: "girlwhite")!,
         UIImage(named: "girlblack")!
        
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! StoresCollectionViewCell
        cell.productName.text = array[indexPath.row]
        cell.storeImage.image=logoImage[indexPath.row]
        cell.productPrice.text=arrayPrice[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var pageIndex: Int = 0
    var strTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionData.dataSource = self
        collectionData.delegate = self
      
         nameLabel.text = strTitle
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
