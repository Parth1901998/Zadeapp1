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
        

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        rightSwipe.direction = .right
        self.segmentcontrol.addGestureRecognizer(rightSwipe)

        segmentcontrol.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        segmentcontrol.setBackgroundImage(UIImage(),for: .normal, barMetrics: .default)


        segmentcontrol.backgroundColor = .clear

//         Do any additional setup after loading the view.
    }

    func swiped(sender:UIGestureRecognizer){
        print("Swiped.....!")
    }
    
   
    
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    
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


