//
//  Section.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 25/07/2021.
//

import Foundation
class Section {
    private var id: Int
    private var title: String
    private var _description: String
    private var srcIcon: String?

    public var description: String {
        return "section [\(self.id), \(self.title), \(self._description), \(String(describing: self.srcIcon))]"
    }
    
    init(id: Int, title: String, description: String, srcIcon: String?) {
        self.id = id
        self.title = title
        self._description = description
        self.srcIcon = srcIcon
    }
    
    public static func sectionFromDictionary(_ section: [String: Any]) -> Section? {
        guard let id = section["idsection"] as? Int else{
            print("Error in searching idsection")
            return nil
        }
        guard let title = section["title"] as? String else{
            print("Error in searching title")
            return nil
        }
        guard let description = section["description"] as? String else{
            print("Error in searching description")
            return nil
        }
        let srcIcon = section["srcicon"] as? String
        return Section(id: id, title: title, description: description, srcIcon: srcIcon)
    }
    
    public func getId() -> Int{
        return self.id
    }
    public func getTitle() -> String{
        return self.title
    }
    public func getDescription() -> String{
        return self._description
    }
    public func getSrcIcon() -> String?{
        return self.srcIcon
    }
    
}
