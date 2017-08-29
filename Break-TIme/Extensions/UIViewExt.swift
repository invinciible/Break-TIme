//
//  UIViewExt.swift
//  Break-TIme
//
//  Created by Tushar Katyal on 29/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
// MArk : Custom class to bind keyboard with send button

import UIKit

extension UIView {
    
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillchange(_ notif : NSNotification) {
        
        let duration = notif.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notif.userInfo![UIKeyboardAnimationCurveUserInfoKey] as? UInt
        let beginningFrame = (notif.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notif.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue : curve!), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}
