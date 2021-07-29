//
//  RequestGetCommentaries.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 29/07/2021.
//

import Foundation
import UIKit
class RequestGetCommentaries{
    enum Result<Commentary> {
        case Success([Commentary])
        case Error(String, Int)
    }

    public static func requestGetCommentariesByIdPost(spinner: UIActivityIndicatorView!, idPost: Int, completion: @escaping (Result<Commentary>) -> Void){
        spinner.startAnimating()
        guard let url = URL(string: "http://0.0.0.0:3000/getCommentaryListByIdPost?idPost=" + String(idPost)) else {
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
                guard let commentaries = body["data"] as? [ [String: Any] ] else{
                    completion(.Success([]))
                    return
                }
                let res = commentaries.compactMap(Commentary.commentaryFromDictionary(_:))
                completion(.Success(res))
            } catch let error {
                print(error.localizedDescription)
                completion(.Error(error.localizedDescription, 400))
            }
        }).resume()
     }
}
