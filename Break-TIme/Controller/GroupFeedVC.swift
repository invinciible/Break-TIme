//
//  GroupFeedVC.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 31/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    
    // outlets
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageField: InsetTextField!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    //variables
    var group : Group?
    func initData(forGroup group : Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.delegate = self
        sendBtnView.bindToKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DataService.instance.getEmail(forGroup: group!) { (returnedEmail) in
            self.membersLbl.text = returnedEmail.joined(separator: ",")
        }
        groupTitleLbl.text = group?.title
        
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension GroupFeedVC : UITextFieldDelegate { }
