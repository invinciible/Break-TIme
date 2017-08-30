//
//  SecondViewController.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 28/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    var groupArray = [Group]()
    @IBOutlet weak var groupTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
//        groupTableView.estimatedRowHeight = 100
//        groupTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroups) in
                self.groupArray = returnedGroups
                self.groupTableView.reloadData()
            }
        }
       
    }

}

extension GroupsVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell()}
        let group = groupArray[indexPath.row]
        cell.configureCell(title: group.title, description: group.description, noOfMembers: group.membersCount)
        return cell
    }
    
}

