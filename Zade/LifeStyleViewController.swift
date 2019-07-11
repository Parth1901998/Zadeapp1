//
//  LifeStyleViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class LifeStyleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    
    @IBOutlet weak var lifestyleTableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headinglife.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeStyle", for: indexPath) as! LifeStyleTableViewCell
        cell.lifeStylelogimage.image = self.imagesslife[indexPath.row]
          cell.lifestyleHeading.text = self.headinglife[indexPath.row]
          cell.lifestyleTitle.text = self.titlelife[indexPath.row]
          cell.lifestyleDesc.text = self.descriptionlife[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    let headinglife = [("friends"),("travel"),("lifestyle"),("fashion"),("lifestyleblog")]
    let imagesslife = [UIImage(named: "friends"), UIImage(named: "travel"), UIImage(named: "lifestyle"), UIImage(named: "fashion"), UIImage(named: "lifestyleblog")]
     let titlelife = [("friends"),("travel"),("lifestyle"),("fashion"),("lifestyleblog")]
    let descriptionlife = [("Travel With your friedns and enjoy your journey"),("travelling gives you the exicitment"),("live your life and enjoy"),("fashion is the key point of human life"),("post your daily life style in a blog")]


    override func viewDidLoad() {
        super.viewDidLoad()
        lifestyleTableView.delegate = self
        lifestyleTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}
