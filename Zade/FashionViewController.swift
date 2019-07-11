//
//  FashionViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 10/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class FashionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet weak var fashionTableview: UITableView!
    
     var headingarray = ["fashion", "fashion", "fashion", "fashion"]
    
    var titlearray = ["Top Trending shoes of all time", "Top Trending handbags of all time","Top Trending white frok of all time","Top Trending blackFrok of all time"]
    
    var logoImage: [UIImage] = [
        UIImage(named: "fashion.png")!,
        UIImage(named: "friends.png")!,
        UIImage(named: "lifestyle.png")!,
        UIImage(named: "travel.png")!
        
    ]
    
    var detailarray = ["vbvqerbveqvneneiqveqveq","fefbvqerbveqvneneiqveqveq","ffgwehnwwtbrw","rfrgevbvqerbveqvneneiqveqveq"]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fashionTableview.delegate = self
        fashionTableview.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(headingarray.count)
        return headingarray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fashioncell", for: indexPath) as! FashionTableViewCell
        cell.fashionImageBlog.image = logoImage[indexPath.row]
        cell.headingBlog.text = headingarray[indexPath.row]
        cell.titleBlog.text = titlearray[indexPath.row]
        cell.descriptionBlog.text = detailarray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}



