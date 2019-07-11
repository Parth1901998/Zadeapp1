//
//  TravelViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headinglife.count
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
        return 250
    }
    
    
    @IBOutlet weak var travelTableView: UITableView!
    
    let headinglife = [("friends"),("travel"),("lifestyle"),("fashion"),("lifestyleblog")]
    let imagesslife = [UIImage(named: "friends"), UIImage(named: "travel"), UIImage(named: "lifestyle"), UIImage(named: "fashion"), UIImage(named: "lifestyleblog")]
    let titlelife = [("friends"),("travel"),("lifestyle"),("fashion"),("lifestyleblog")]
    let descriptionlife = [("Travel With your friedns and enjoy your journey"),("travelling gives you the exicitment"),("live your life and enjoy"),("fashion is the key point of human life"),("post your daily life style in a blog")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        travelTableView.dataSource = self
        travelTableView.delegate = self

    }
    

 

}
