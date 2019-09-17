//
//  UIViewController+Helper.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/16/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK:- Adding navigation button
    func setupAddBtnNavbar(selector : Selector){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: selector)
        navigationItem.rightBarButtonItem!.tintColor = .darkGray
    }
    
    //MARK:- Default alert view
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MAKR:- Validate email by Regex
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
}

