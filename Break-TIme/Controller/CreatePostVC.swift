//
//  CreatePostVC.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 29/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {

    // outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.bindToKeyboard()
        // Do any additional setup after loading the view.
    }


    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if textView.text != nil && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUid: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isSuccess) in
                if isSuccess {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("tush : Error posting")
                   
                }
            })
        }
    }
    
}
