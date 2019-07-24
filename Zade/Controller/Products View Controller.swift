//
//  Products View Controller.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseAuth



class Products_View_Controller: UIViewController {
    
    

    
    @IBOutlet weak var productSearch: UISearchBar!
    
       
    @IBOutlet weak var newArrivals: UIView!
    
    @IBOutlet weak var newcollections: UIView!
    
    @IBOutlet weak var bestSellers: UIView!
    
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segments.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segments.layer.borderColor = UIColor.white.cgColor
        segments.layer.borderWidth = 1.0
        
        segments.setBackgroundImage(UIImage(),for: .normal, barMetrics: .default)
        
     
        
        
        segments.backgroundColor = .clear
        
        
    }
    
    //MARK : - Segment Switch
    
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
    
    @IBAction func backToSide(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
    
    

    


