//
//  ProductHomeViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 09/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class ProductHomeViewController: UIViewController {
    
    
    @IBOutlet weak var fashionview: UIView!
    
    @IBOutlet weak var lifestyleview: UIView!
    
    @IBOutlet weak var travelview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            fashionview.alpha = 1
            lifestyleview.alpha = 0
            travelview.alpha = 0
        }
       
        
        else if sender.selectedSegmentIndex == 1{
            fashionview.alpha = 0
            lifestyleview.alpha = 1
            travelview.alpha = 0
            
        }
        else if sender.selectedSegmentIndex == 2
        {
            fashionview.alpha = 0
            lifestyleview.alpha = 0
            travelview.alpha = 1
        }
    }
    
}


