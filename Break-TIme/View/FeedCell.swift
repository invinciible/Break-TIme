//
//  FeedCell.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 30/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var feedContent: UILabel!
    @IBOutlet weak var userProfileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message : Message , image : UIImage) {
        
        userEmail.text = message.senderId
        feedContent.text = message.content
        userProfileImg.image = image
    }

}
