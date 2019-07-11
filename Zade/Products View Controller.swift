//
//  Products View Controller.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class Products_View_Controller: UIViewController {
    
    
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    
    @IBOutlet weak var newArrivals: UIView!
    
    @IBOutlet weak var newcollections: UIView!
    
    @IBOutlet weak var bestSellers: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentSwitch(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            newArrivals.alpha = 1
            newcollections.alpha = 0
            bestSellers.alpha = 0
        }
            
            
        else if sender.selectedSegmentIndex == 1{
            newArrivals.alpha = 0
            newcollections.alpha = 1
            bestSellers.alpha = 0
            
        }
        else if sender.selectedSegmentIndex == 2
        {
            newArrivals.alpha = 0
            newcollections.alpha = 0
            bestSellers.alpha = 1
        }
    }
}
    
    

    


