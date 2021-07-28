//
//  Individual.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 06/06/2021.
//

import Foundation
class Individual {
    
    private var id: Int
    private var pseudo: String
    private var password: String
    private var salt: String
    private var status: String
    private var email: String
    private var birthday: String?
    private var registerDate: String
    
    public var description: String {
        return "market [\(self.id), \(self.pseudo), \(self.password), \(self.salt), \(self.status), \(self.email), \(String(describing: self.birthday)), \(self.registerDate)]"
    }
    
    init(id: Int, pseudo: String, password: String, salt: String, status: String, email: String, birthday: String?, registerDate: String) {
        self.id = id
        self.pseudo = pseudo
        self.password = password
        self.salt = salt
        self.status = status
        self.email = email
        self.birthday = birthday
        self.registerDate = registerDate
    }
    public static func individualFromDictionary(_ dict: [String: Any]) -> Individual? {
        if let body = dict["body"] as? [String: Any]{
            if let data = body["data"] as? [Any]{
                //dump(data)
                if let data1 = data[0] as? [String: Any]{
                    guard let id = data1["idindividual"] as? Int else{
                        return nil
                    }
                    guard let pseudo = data1["pseudo"] as? String else{
                        return nil
                    }
                    guard let email = data1["email"] as? String else{
                        return nil
                    }
                    guard let status = data1["status"] as? String else{
                        return nil
                    }
                    guard let password = data1["password"] as? String else{
                        return nil
                    }
                   guard let salt = data1["salt"] as? String else{
                        return nil
                   }
                   guard let registerDate = data1["registerdate"] as? String else{
                        return nil
                    }
                    let birthday = data1["birthday"] as? String
                    return Individual(id: id, pseudo: pseudo, password: password, salt: salt, status: status, email: email, birthday: birthday, registerDate: registerDate)
                }
                
            }

        }
        return nil
    }
    
    public func getId() -> Int{
        return self.id
    }
    public func getPseudo() -> String{
        return self.pseudo
    }
    public func getPassword() -> String{
        return self.password
    }
    public func getSalt() -> String{
        return self.salt
    }
    public func getStatus() -> String{
        return self.status
    }
    public func getEmail() -> String{
        return self.email
    }
    public func getBirthday() -> String{
        return self.birthday!
    }
    public func getRegisterDate() -> String{
        return self.registerDate
    }
}
