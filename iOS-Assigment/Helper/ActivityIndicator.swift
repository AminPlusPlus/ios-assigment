//
//  ActivityIndicator.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/17/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func showActivityIndicator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        DispatchQueue.main.async {
            self.containerView.frame = window.frame
            self.containerView.center = window.center
            self.containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
            
            self.progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.progressView.center = window.center
            self.progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
            self.progressView.clipsToBounds = true
            self.progressView.layer.cornerRadius = 10
            
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.center = CGPoint(x: self.progressView.bounds.width / 2, y: self.progressView.bounds.height / 2)
            
            self.progressView.addSubview(self.activityIndicator)
            self.containerView.addSubview(self.progressView)
            UIApplication.shared.keyWindow?.addSubview(self.containerView)
            
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

