//
//  CreateGroupVC.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 30/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var emailSearchField: InsetTextField!
    @IBOutlet weak var descriptionField: InsetTextField!
    @IBOutlet weak var titleField: InsetTextField!
    @IBOutlet weak var groupMembersLbl: UILabel!
    // variable
    var emailArray = [String]()
    var selectedUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        emailSearchField.delegate = self
        emailSearchField.addTarget(self, action: #selector(emailFieldDidChanged), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        doneBtn.isHidden = true
    }

 
    @objc func emailFieldDidChanged() {
        
        if emailSearchField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    // Actions
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        if titleField.text != "" && descriptionField.text != "" {
            DataService.instance.getIdForUserName(forUsernames: selectedUserArray, handler: { (uidsForGroupUsers) in
                var uIds = uidsForGroupUsers
                uIds.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(withTitle: self.titleField.text!, andDescription: self.descriptionField.text!, forIds: uIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("group is not created ")
                    }
                })
            })
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension CreateGroupVC : UITableViewDelegate,UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? userCell else {return UITableViewCell() }
        if selectedUserArray.contains(emailArray[indexPath.row]) {
             cell.configureCell(profileImg: #imageLiteral(resourceName: "defaultProfileImage"), email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImg: #imageLiteral(resourceName: "defaultProfileImage"), email: emailArray[indexPath.row], isSelected: false)
        }
    
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let cell = tableView.cellForRow(at: indexPath) as? userCell else {return}
        if !selectedUserArray.contains(cell.emailLbl.text!) {
            selectedUserArray.append(cell.emailLbl.text!)
             groupMembersLbl.text = selectedUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            selectedUserArray = selectedUserArray.filter({ $0 != cell.emailLbl.text! })
            if selectedUserArray.count >= 1{
                groupMembersLbl.text = selectedUserArray.joined(separator: ", ")
            } else {
                groupMembersLbl.text = "Add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
    
}

extension CreateGroupVC : UITextFieldDelegate {
    
}







