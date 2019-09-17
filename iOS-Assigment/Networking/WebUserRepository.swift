//
//  WebUserRepository.swift
//  iOS-Assigment
//
//  Created by Aminjoni Abdullozoda on 9/17/19.
//  Copyright © 2019 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation

class WebUserRepository {
    
    //MARK:- Fetch users data
    func fetchUsers (successHandler : @escaping ((Users) -> Void), errorHandler: @escaping (Error?) -> Void) {
        
        let url = URL(string: Networking.ResoursePath.users.path)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (result, responce, err) in
         
            guard let data = result else { return }
            let users = try? JSONDecoder().decode(Users.self, from: data)
            successHandler(users ?? [])
        
            if err != nil {
                errorHandler(err)
            }
        }
        
        task.resume()
    }
    
    //MARK:- Create new user
    func createNewUser (params : [String : Any],successHandler : @escaping ((String) -> Void)) {
        
        let url = URL(string: Networking.ResoursePath.users.path)!
        let requestParam = ["user" : params]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestParam, options: []) else {
            return
        }

        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            if let response = responce {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    successHandler("создал нового пользователя")
                    print(json)
                } catch {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    //MARK:- Update user info
    func updateUserData (idUser: String,params : [String : Any],successHandler : @escaping ((String) -> Void)) {
        
        let url = URL(string: "\(Networking.ResoursePath.user.path)/\(idUser).json")!
        let requestParam = ["user" : params]
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestParam, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            if let response = responce {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    successHandler("Обновить данные пользователя")
                    print(json)
                } catch {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
}
