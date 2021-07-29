//
//  Post.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 27/07/2021.
//

import Foundation
class Post {
    private var id: Int
    private var title: String
    private var content: String
    private var srcImage: String?
    private var numberpush: Int
    private var creationDate: String
    private var endLifeData: String?
    private var isReceivedReport: Int?
    private var idSection: Int

    public var description: String {
        return "post [\(self.id), \(self.title), \(self.content), \(self.numberpush), \(self.creationDate), \(String(describing: self.endLifeData)), \(self.isReceivedReport), \(self.idSection), \(String(describing: self.srcImage))]"
    }
    
    init(id: Int, title: String, content: String, srcImage: String?, numberpush: Int, creationDate: String, endLifeData: String?, isReceivedReport: Int?, idSection: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.srcImage = srcImage
        self.numberpush = numberpush
        self.creationDate = creationDate
        self.endLifeData = endLifeData
        self.isReceivedReport = isReceivedReport
        self.idSection = idSection
    }
    
    public static func postFromDictionary(_ post: [String: Any]) -> Post? {
        guard let id = post["idpost"] as? Int else{
            print("Error in searching idPost")
            return nil
        }
        guard let title = post["title"] as? String else{
            print("Error in searching title")
            return nil
        }
        guard let content = post["content"] as? String else{
            print("Error in searching description")
            return nil
        }
        guard let numberPush = post["numberpush"] as? Int else{
            print("Error in searching numberPush")
            return nil
        }
        guard let creationDate = post["creationdate"] as? String else{
            print("Error in searching creationdate")
            return nil
        }
        guard let idSection = post["section_idsection"] as? Int else{
            print("Error in searching idsection")
            return nil
        }
        let srcImage = post["srcimage"] as? String
        let endLifeData = post ["endlifedata"] as? String
        return Post(id: id, title: title, content: content, srcImage: srcImage, numberpush: numberPush, creationDate: creationDate, endLifeData: endLifeData, isReceivedReport: 0, idSection: idSection)
    }
    
    public func getId() -> Int{
        return self.id
    }
    public func getTitle() -> String{
        return self.title
    }
    public func getContent() -> String{
        return self.content
    }
    public func getSrcImage() -> String?{
        return self.srcImage
    }
    public func getNumberpush() -> Int{
        return self.numberpush
    }
    public func getCreationDate() -> String{
        return self.creationDate
    }
    public func getEndLifeData() -> String?{
        return self.endLifeData
    }
    public func getIsReceivedReport() -> Int{
        return self.isReceivedReport!
    }
    public func getIdSection() -> Int{
        return self.idSection
    }
    
}
