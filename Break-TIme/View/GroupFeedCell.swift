//
//  GroupFeedCell.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 31/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var userProfileImg : UIImageView!
    @IBOutlet weak var userEmail : UILabel!
    @IBOutlet weak var message : UILabel!
    
    
    func configureCell( profileImg : UIImage, email : String , message : String) {
        
        self.message.text = message
        self.userEmail.text = email
        self.userProfileImg.image = profileImg
    }
    
    
}
