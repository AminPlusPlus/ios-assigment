//
//  NewUserViewController.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/16/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit


class NewUserViewController: UIViewController {
    
    
    var user : UserElement? {
        didSet {
            nameTextField.text = user?.firstName
            surnameTextField.text = user?.lastName
            emailTextField.text = user?.email
            saveButton.setTitle("Обновить", for: .normal)
        }
    }
    
    //MARK:- UI Elements
    private let vStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "имя"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    private let surnameTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "фамилия"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    private let emailTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "электронное письмо"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    private lazy var saveButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Создать", for: .normal)
        btn.backgroundColor = .darkGray
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        
        btn.addTarget(self, action: #selector(saveNewUser), for: .touchUpInside)
        
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = user == nil ? "Создать" : "Редактировать"
        
        setupView()
        
        //end editing gesture to view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    //MARK:- Setup View & Constrains
    private func setupView(){
        view.addSubview(vStackView)
        
        
        vStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true

        vStackView.addArrangedSubview(nameTextField)
        vStackView.addArrangedSubview(surnameTextField)
        vStackView.addArrangedSubview(emailTextField)
        vStackView.addArrangedSubview(saveButton)
        
       nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    //MARK:- Save new user && Update it
    @objc private func saveNewUser () {
        
        //validation
        guard let name = nameTextField.text, !name.isEmpty else {
            alert(message: "Пожалуйста, введите ваше имя")
            return }
        guard let surname = surnameTextField.text, !surname.isEmpty else {
            alert(message: "Пожалуйста, введите вашу фамилию")
            return }
        guard let email = emailTextField.text, !email.isEmpty else {
            alert(message: "Пожалуйста, введите ваш адрес электронной почты")
            return }
        
        //validate email
        if isValidEmail(emailStr: email) {
            let param = ["first_name" : name,"last_name":surname,"email":email, "avatar_url" : ""]
            
            ActivityIndicator.shared.showActivityIndicator()
            if user == nil {
                //post to save
                WebUserRepository().createNewUser(params: param) { (successMessage) in
                    
                    DispatchQueue.main.async {
                        ActivityIndicator.shared.hideActivityIndicator()
                        self.nameTextField.text = ""
                        self.surnameTextField.text = ""
                        self.emailTextField.text = ""
                        self.nameTextField.becomeFirstResponder()
                        self.alert(message: successMessage)
                    }
                }
            } else {
                //update user data
                WebUserRepository().updateUserData(idUser: user!.id.description, params: param) { (successMessage) in
                    DispatchQueue.main.async {
                        ActivityIndicator.shared.hideActivityIndicator()
                        self.alert(message: successMessage)
                    }
                    
                }
                
            }
        } else {
            alert(message: "Пожалуйста, проверьте формат вашей электронной почты")
        }
    }
    
    //MARK:- Save new user
    @objc private func endEditing(){
        view.endEditing(true)
    }
}
