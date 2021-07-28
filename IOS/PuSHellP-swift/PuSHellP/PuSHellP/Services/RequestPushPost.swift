//
//  RequestPushPost.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 29/07/2021.
//

import Foundation
import UIKit

class RequestPushPost{
    enum Result<Int> {
        case Success(Int)
        case Error(String, Int)
    }
    public static func pushPostByIdUserWithIdPost(spinner: UIActivityIndicatorView!, idUser: Int, idPost: Int, completion: @escaping (Result<Int>) -> Void){
        spinner.startAnimating()
        guard let uri = URL(string: "http://0.0.0.0:3000/pushPostByIdUserWithIdPost") else {
            completion(.Error("Invalid URL", 401))
            //completion(nil)
            return
        }
        let parameters = ["idUser": idUser, "idPost": idPost] as [String : Any]

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: uri)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil, let data = data else {
                completion(.Error("error connecting to the api server", 500))
                return
            }

            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(.Error("format json incorrect", 400))
                    return
                }
                if let error = json["error"] as? String{
                    completion(.Error(error, 400))
                    return
                }
                guard let body = json["body"] as? [String: Any] else{
                    completion(.Error("error body not found", 404))
                    return
                }
                guard let numberpush = body["data"] as? Int else{
                    completion(.Error("error posts not found", 404))
                    return
                }
                completion(.Success((numberpush)))
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
