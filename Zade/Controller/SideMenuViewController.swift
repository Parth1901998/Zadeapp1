//
//  SideMenuViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore

class SideMenuViewController:
UIViewController,UITableViewDelegate,UITableViewDataSource,ExpandableHeaderViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = contentViewController()
        content.customInit(imageName: sections[indexPath.section].collected[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(content, animated: true)
//        let Vc = storyboard?.instantiateViewController(withIdentifier: "product") as! NewArrivals
//        self.navigationController?.pushViewController(Vc, animated: true)
       
    }
    
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.beginUpdates()
        for i in 0 ..< sections[section].collected.count{
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].collected[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded){
            return 44
        }
        else
        {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].men, section: section, delegate: self)
        return header
    }
    
    var sections = [Section(men: "For Men", collected: ["T-Shirt","Shoes","jacket","Asesories"], expanded: false),
                    Section(men: "For women", collected: ["T-Shirt","Shoes","jacket","Asesories"], expanded: false)]
    

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var userImageHere: UIImageView!
    
    
    @IBOutlet weak var userNameHere: UILabel!
    
    
    @IBAction func bestSellerCollection(_ sender: UIButton) {
        
        let BestSeller = storyboard?.instantiateViewController(withIdentifier: "product") as! Products_View_Controller
        self.navigationController?.pushViewController(BestSeller, animated: true)
        
    
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    @IBAction func greenBackButton(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ProductHomeViewController = storyBoard.instantiateViewController(withIdentifier: "ProductHomeViewController") as! ProductHomeViewController
        self.present(ProductHomeViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   UINavigationBar.appearance().tintColor = .white
        self.searchBar.layer.cornerRadius = 20 
        self.searchBar.clipsToBounds = true
        searchBar.layer.borderWidth = 1

        let user = Auth.auth().currentUser
        userNameHere.text = user?.displayName
        let url = user?.photoURL
        
        
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            userImageHere.image = image
            userImageHere.layer.borderWidth = 1
            userImageHere.layer.masksToBounds = false
            userImageHere.layer.borderColor = UIColor.black.cgColor
            userImageHere.layer.cornerRadius = userImageHere.frame.height/2
            userImageHere.clipsToBounds = true

        // Do any additional setup after loading the view.
    
        }
    
    }
    
    @IBAction func GOToProfile(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UserProfileViewController = storyBoard.instantiateViewController(withIdentifier: "Profile") as! UserProfileViewController
        self.present(UserProfileViewController, animated:true, completion:nil)
        
    }
    
}
