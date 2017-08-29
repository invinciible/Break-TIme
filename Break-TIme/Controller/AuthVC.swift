//
//  AuthVC.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 29/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Actions
    @IBAction func fbSignInBtnWasPressed(_ sender: Any) {
    }
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
    }
    
    //Segue to loginVc
    @IBAction func signInWithEmailBtnWasPressed(_ sender: Any) {
        
        let loginvc = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginvc!, animated: true, completion: nil)
    }
    
}
