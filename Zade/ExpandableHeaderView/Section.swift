//
//  Section.swift
//  Zade
//
//  Created by Parth Bhojak on 11/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import Foundation
struct Section {
  
    var men : String!
    var collected : [String]!
    var expanded: Bool
    
    
    init( men:String,collected:[String],expanded : Bool)
    {
        
        self.men = men
        self.collected = collected
        self.expanded = expanded
    }
}
