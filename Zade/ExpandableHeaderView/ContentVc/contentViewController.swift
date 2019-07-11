//
//  contentViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

class contentViewController: UIViewController {
    var imageName: String!
    
    @IBOutlet weak var contentImages: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentImages.image = UIImage(named:imageName)
        self.title = imageName

        // Do any additional setup after loading the view.
    }
    func customInit(imageName: String)
    {
        self.imageName = imageName
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
