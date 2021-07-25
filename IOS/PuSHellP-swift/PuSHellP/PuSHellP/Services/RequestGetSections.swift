//
//  RequestGetSections.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 25/07/2021.
//

import Foundation

class RequestGetSections{

    enum Result<Section> {
        case Success([Section])
        case Error(String, Int)
    }

    public static func requestGetSections(completion: @escaping (Result<Section>) -> Void){
        guard let url = URL(string: "http://0.0.0.0:3000/getSections") else {
            completion(.Error("Invalid URL", 401))
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let data = data else {
                completion(.Error("error api server", 401))
                return
            }
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(.Error("format json incorrect", 400))
                    return
                }
                if let error = json["error"] as? String{
                    print(error)
                    completion(.Error(error, 400))
                    return
                }
                guard let body = json["body"] as? [String: Any] else{
                    completion(.Error("error body not found", 404))
                    return
                }
                guard let sections = body["data"] as? [ [String: Any] ] else{
                    completion(.Error("error sections not found", 404))
                    return
                }
                let res = sections.compactMap(Section.sectionFromDictionary(_:)) 
                completion(.Success(res))
            } catch let error {
                print(error.localizedDescription)
                completion(.Error(error.localizedDescription, 400))
            }
        }).resume()
     }
}
