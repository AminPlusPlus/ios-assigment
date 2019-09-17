//
//  HomeTableViewCell.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/16/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    //Mark:- UI Elements
    private let userImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView()
        setupUI()
    }
    
    //MARK:- Setup UI & Constrains
    private func setupUI(){
        addSubview(userImageView)
        
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 15).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 80).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        
        addSubview(subTitleLabel)
        subTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 80).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    //MARK:- Update Cell
    func updateCell (user : UserElement) {
        titleLabel.text = "\(user.firstName) \(user.lastName)"
        subTitleLabel.text = user.email

        guard let imageURL = user.avatarURL, !imageURL.isEmpty else { return}
        
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(with: URL(string: imageURL)!, placeholder: UIImage(named: "user"), options:
        [.transition(.fade(0.2))])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

