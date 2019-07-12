//
//  SideMenuViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit

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
    
    
    @IBAction func bestSellerCollection(_ sender: UIButton) {
        
        let BestSeller = storyboard?.instantiateViewController(withIdentifier: "product") as! Products_View_Controller
        self.navigationController?.pushViewController(BestSeller, animated: true)
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
