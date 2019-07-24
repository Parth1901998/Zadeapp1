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
import GoogleSignIn

class SideMenuViewController:
UIViewController,UITableViewDelegate,UITableViewDataSource,ExpandableHeaderViewDelegate {
    
    
    // MARK: tableView Methods
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = contentViewController()
        content.customInit(imageName: sections[indexPath.section].collected[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(content, animated: true)
    
       
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
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded){
            return 50
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
   func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = .white
        header.textLabel?.textColor = .black
        header.textLabel?.textAlignment = .left
        header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
    }
    
  
    
    var sections = [Section(men: "FOR MEN", collected: ["T-Shirt(13)","Shoes(25)","Jacket(48)","Asesories(96)"], expanded: false),
                    Section(men: "FOR WOMEN", collected: ["T-Shirt(13)","Shoes(25)","Jacket(48)","Asesories(96)"], expanded: false)]
    
  


    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var userImageHere: UIImageView!
    
    
    @IBOutlet weak var userNameHere: UILabel!
    
    
    @IBAction func bestSellerCollection(_ sender: UIButton) {
        
//        let BestSeller = storyboard?.instantiateViewController(withIdentifier: "product") as! Products_View_Controller
//        self.navigationController?.pushViewController(BestSeller, animated: true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UserPostViewController = storyBoard.instantiateViewController(withIdentifier: "product") as! Products_View_Controller
        self.present(UserPostViewController, animated:true, completion:nil)

    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
             GIDSignIn.sharedInstance().signOut()
//          self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
//
           self.dismiss(animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    @IBAction func greenBackButton(_ sender: UIButton) {
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let ProductHomeViewController = storyBoard.instantiateViewController(withIdentifier: "ProductHomeViewController") as! ProductHomeViewController
//        self.present(ProductHomeViewController, animated:true, completion:nil)
        
//        let BestSeller = storyboard?.instantiateViewController(withIdentifier: "product") as! Products_View_Controller
//        self.navigationController?.pushViewController(BestSeller, animated: true)
        self.dismiss(animated: true, completion: nil)

    }
    
     let db = Firestore.firestore()
    
    let uuid = UUID().uuidString
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
    
        
   UINavigationBar.appearance().tintColor = .white
        self.searchBar.layer.cornerRadius = 20 
        self.searchBar.clipsToBounds = true
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor

        let user = Auth.auth().currentUser
        userNameHere.text = user?.displayName
        let url = user?.photoURL


        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            userImageHere.image = image
//            userImageHere.layer.borderWidth = 1
            userImageHere.layer.masksToBounds = false
//            userImageHere.layer.borderColor = UIColor.black.cgColor
            userImageHere.layer.cornerRadius = userImageHere.frame.height/2
            userImageHere.clipsToBounds = true


        }
    
    }
    
    @IBAction func GOToProfile(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UserProfileViewController = storyBoard.instantiateViewController(withIdentifier: "Profile") as! UserProfileViewController
        self.present(UserProfileViewController, animated:true, completion:nil)
        
    }
    
}
