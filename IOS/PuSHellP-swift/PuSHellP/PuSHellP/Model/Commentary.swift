//
//  Commentary.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 29/07/2021.
//

import Foundation
class Commentary{
    private var id: Int
    private var text: String
    private var datecreation: String
    private var idUser: Int
    private var idPost: Int
    
    public var description: String {
        return "commentary [\(self.id), \(self.text), \(self.datecreation), \(self.idUser), \(self.idPost)]"
    }
    
    init(id: Int, text: String, datecreation: String, idUser: Int, idPost: Int) {
        self.id = id
        self.text = text
        self.datecreation = datecreation
        self.idUser = idUser
        self.idPost = idPost
    }
    
    public static func commentaryFromDictionary(_ commentary: [String: Any]) -> Commentary? {
        guard let id = commentary["idcommentary"] as? Int else{
            print("Error in searching idPost")
            return nil
        }
        guard let text = commentary["text"] as? String else{
            print("Error in searching title")
            return nil
        }
        guard let datecreation = commentary["datecreation"] as? String else{
            print("Error in searching description")
            return nil
        }
        guard let individual_idindividual = commentary["individual_idindividual"] as? Int else{
            print("Error in searching numberPush")
            return nil
        }
        guard let post_idpost = commentary["post_idpost"] as? Int else{
            print("Error in searching idsection")
            return nil
        }
        return Commentary(id: id, text: text, datecreation: datecreation, idUser: individual_idindividual, idPost: post_idpost)
    }
    
    public func getId() -> Int{
        return self.id
    }
    public func getText() -> String{
        return self.text
    }
    public func getDatecreation() -> String{
        return self.datecreation
    }
    public func getIdUser() -> Int{
        return self.idUser
    }
    public func getIdPost() -> Int{
        return self.idPost
    }
}
