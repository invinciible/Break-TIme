//
//  userCell.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 30/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {

    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var emailLbl : UILabel!
    @IBOutlet weak var checkImg : UIImageView!
     var showing = false
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        if selected {
            if showing {
            checkImg.isHidden = true
                showing = false
            } else {
                checkImg.isHidden = false
                showing = true
            }
        }
        
    }
    func configureCell(profileImg : UIImage , email : String , isSelected : Bool) {
        profileImage.image = profileImg
        emailLbl.text = email
        if isSelected {
            checkImg.isHidden = false
        } else {
            checkImg.isHidden = true
        }
    }

}
