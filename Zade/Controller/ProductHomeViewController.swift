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
    
    
   // MARK: ViewDidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left

        segmentcontrol.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        segmentcontrol.setBackgroundImage(UIImage(),for: .normal, barMetrics: .default)


        segmentcontrol.backgroundColor = .clear

//         Do any additional setup after loading the view.
    }

    @objc func swipedRight(){
        segmentcontrol.selectedSegmentIndex -= 1
    }
    
    @objc func swipedLeft(){
        segmentcontrol.selectedSegmentIndex += 1
    }
    
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    
    // MARK: SegmentControl
    
    
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


