//
//  CreateGroupVC.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 30/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var emailSearchField: InsetTextField!
    @IBOutlet weak var descriptionField: InsetTextField!
    @IBOutlet weak var titleField: InsetTextField!
    @IBOutlet weak var groupMembersLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    // Actions
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
    }
    
}
