//
//  ViewController.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/16/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    var users : Users = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Пользователи"
        setupTable()
        setupAddBtnNavbar(selector: #selector(addUser))
        
        ActivityIndicator.shared.showActivityIndicator()
        WebUserRepository().fetchUsers(successHandler: { (users) in
            self.users = users
            
            //update ui main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            ActivityIndicator.shared.hideActivityIndicator()
        }) { (err) in
            self.alert(message: err?.localizedDescription ?? "Error")
            ActivityIndicator.shared.hideActivityIndicator()
        }
        
    }
    
    private func setupTable() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 75
    }
    
    @objc private func addUser () {
        navigationController?.pushViewController(NewUserViewController(), animated: true)
    }

}

