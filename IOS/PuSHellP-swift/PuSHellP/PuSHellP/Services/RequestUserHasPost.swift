//
//  RequestGetIndividualsWithPostsByIds.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 28/07/2021.
//

import Foundation
import UIKit
class RequestUserHasPost{
    enum Result<Int> {
        case Success(Int)
        case Error(String, Int)
    }
    public static func requestGetIndividualsWithPostsByIds(spinner: UIActivityIndicatorView!, idUser: Int, idPost: Int, completion: @escaping (Result<Int>) -> Void){
        spinner.startAnimating()
        guard let url = URL(string: "http://0.0.0.0:3000/getIndividualsWithPostsByIds?idUser=" + String(idUser) + "&idPost=" + String(idPost)) else {
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
                guard let data = body["data"] as? [[String: Any]] else{
                    completion(.Error("error posts not found", 404))
                    return
                }
                let data1 = data[0]
                guard let isUserDidPushThePost = data1["count"] as? String else{
                    completion(.Error("error format data is not correct", 400))
                    return
                }
                completion(.Success(Int(isUserDidPushThePost)!))
            } catch let error {
                completion(.Error(error.localizedDescription, 400))
            }
        }).resume()
     }
}
