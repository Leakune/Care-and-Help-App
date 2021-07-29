//
//  RequestGetUserById.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 29/07/2021.
//

import Foundation
import UIKit

class RequestGetUserById{
    enum Result<Individual> {
        case Success(Individual)
        case Error(String, Int)
    }
    public static func RequestGetUserById(spinner: UIActivityIndicatorView!, idUser: Int, completion: @escaping (Result<Individual>) -> Void){
        spinner.startAnimating()
        guard let url = URL(string: "http://0.0.0.0:3000/getIndividualById?idUser=" + String(idUser)) else {
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
                guard let data = body["data"] as? [ [String: Any] ] else{
                    completion(.Error("error data not found", 404))
                    return
                }
                let user = data[0]
                guard let individual = Individual.individualFromDictionary(user) else{
                    completion(.Error("error getting individual", 400))
                    return
                }
                completion(.Success(individual))
            } catch let error {
                print(error.localizedDescription)
                completion(.Error(error.localizedDescription, 400))
            }
        }).resume()
     }
}
