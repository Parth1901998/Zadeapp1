//
//  NewArrivals.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class NewArrivals: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newarrival", for: indexPath) as! newArrivalViewCell
        cell.newarrivalName.text = array[indexPath.row]
        cell.newarrivalImage.image=logoImage[indexPath.row]
        cell.newarrivalPrice.text=arrayPrice[indexPath.row]
        return cell
    }
    
    
    
    @IBOutlet weak var newArrivalCollection: UICollectionView!
    
    var array = ["Ultra Boosts Shoes", "Star Bags #1", "White Frok", "Black Frok"]
    var arrayPrice = ["$99.69","$99.69","$99.69","$99.69"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "ic_shoes.png")!,
        UIImage(named: "ic_handbag.png")!,
        UIImage(named: "ic_white.png")!,
        UIImage(named: "ic_black.png")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newArrivalCollection.dataSource = self
        newArrivalCollection.delegate = self
        
    }
    


}
