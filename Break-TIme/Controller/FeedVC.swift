//
//  FirstViewController.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 28/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableViewFeed : UITableView!
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFeed.delegate = self
        tableViewFeed.dataSource = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.getAllFeedMessage { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray
            self.tableViewFeed.reloadData()
        }
    }
    
}
extension FeedVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewFeed.dequeueReusableCell(withIdentifier: "FeedCell") as?  FeedCell else {return UITableViewCell() }
        let image = #imageLiteral(resourceName: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        cell.configureCell(message :message,image : image)
        return cell
    }
}

