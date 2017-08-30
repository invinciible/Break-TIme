//
//  Group.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 31/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation

class Group {
    
   public private(set) var title : String
   public private(set) var description : String
   public private(set) var members : [String]
   public private(set) var key : String
   public private(set) var membersCount : Int
    
    init(title : String,description : String,members : [String],key : String,membersCount : Int) {
        self.description = description
        self.title = title
        self.key = key
        self.members = members
        self.membersCount = membersCount
    }
    
}
