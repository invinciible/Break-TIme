//
//  LoginVC.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 29/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // outlets
    @IBOutlet weak var passwordField: InsetTextField!
    @IBOutlet weak var emailField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
    }

    // Actions
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil )
    }
    @IBAction func signInBtnPressed(_ sender: Any) {
        
        guard emailField.text != nil && passwordField.text != nil else {return}
        AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else {
            print(String(describing :error?.localizedDescription))
            }
            AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registerError) in
                if success {
                    print("tush : success register")
                    AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
                        
                        if success {
                            print("tush : success login")
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                } else {
                    print(String(describing: registerError?.localizedDescription))
                }
            })
        }
    }
    

}
extension LoginVC : UITextFieldDelegate {}
