//
//  Individual.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 06/06/2021.
//

import Foundation
class Individual {//classe représentant un utilisateur
    
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
