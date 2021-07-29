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
        guard let id = dict["idindividual"] as? Int else{
            return nil
        }
        guard let pseudo = dict["pseudo"] as? String else{
            return nil
        }
        guard let email = dict["email"] as? String else{
            return nil
        }
        guard let status = dict["status"] as? String else{
            return nil
        }
        guard let password = dict["password"] as? String else{
            return nil
        }
       guard let salt = dict["salt"] as? String else{
            return nil
       }
       guard let registerDate = dict["registerdate"] as? String else{
            return nil
       }
        let birthday = dict["birthday"] as? String
        return Individual(id: id, pseudo: pseudo, password: password, salt: salt, status: status, email: email, birthday: birthday, registerDate: registerDate)
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
