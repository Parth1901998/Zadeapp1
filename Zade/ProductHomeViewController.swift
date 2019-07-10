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
            travelview.alpha = 1
        }
       
        else{
            fashionview.alpha = 0
            lifestyleview.alpha = 1
            travelview.alpha = 0
            
        }
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
