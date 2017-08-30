//
//  GroupCell.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 31/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var gorupTitleLbl: UILabel!
    @IBOutlet weak var noOfMembersLbl: UILabel!
    
    func configureCell(title : String,description :String,noOfMembers : Int) {
        
        gorupTitleLbl.text = title
        descriptionLbl.text = description
        noOfMembersLbl.text = "\(noOfMembers) Members"
    }

}
