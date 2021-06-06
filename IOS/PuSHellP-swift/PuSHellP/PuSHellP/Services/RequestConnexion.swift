//
//  URLRequest.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 06/06/2021.
//

import Foundation

class RequestConnexion{
    
    enum Result<Individual> {
        case Success(Individual)
        case Error(String, Int)
    }
    
    public static func individualFromDictionary(_ dict: [String: Any]) -> Individual? {
        dump(dict)
        if let body = dict["body"] as? [String: Any]{
            if let data = body["data"] as? [Any]{
                //dump(data)
                if let data1 = data[0] as? [String: Any]{
                    print(data1)
                    guard let id = data1["idindividual"] as? Int else{
                        print("Error in searching idindividual:")
                        return nil
                    }
                    guard let pseudo = data1["pseudo"] as? String else{
                        print("Error in searching pseudo:")
                        return nil
                    }
                    guard let email = data1["email"] as? String else{
                        print("Error in searching email:")
                        return nil
                    }
                    guard let status = data1["status"] as? String else{
                        print("Error in searching data status:")
                        return nil
                    }
                    guard let password = data1["password"] as? String else{
                        print("Error in searching password:")
                        return nil
                    }
                    print(type(of: data1["salt"]))
                   guard let salt = data1["salt"] as? String else{
                        print("Error in searching data salt:")
                        return nil
                   }
                   print(type(of: data1["registerdate"]))
                   guard let registerDate = data1["registerdate"] as? String else{
                        print("Error in searching data registerDate:")
                        return nil
                    }
                    let birthday = data1["birthday"] as? String
                    return Individual(id: id, pseudo: pseudo, password: password, salt: salt, status: status, email: email, birthday: birthday, registerDate: registerDate)
                }
                
            }

        }
        return nil
        
    }
    //public static func requestConnexion(urlString: String, pseudo: String, password: String, completion: @escaping (Result<Individual>) -> Void){
    public static func requestConnexion(urlString: String, pseudo: String, password: String, completion: @escaping (Individual?) -> Void){

        guard let uri = URL(string: urlString) else {
            //completion(.Error("Invalid URL", 401))
            completion(nil)
            return
        }
        let parameters = ["username": pseudo, "password": password]

        
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
                //completion(.Error("error api server", 401))
                completion(nil)
                return
            }

            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    //completion(.Error("format json is incorrect", 401))
                    completion(nil)
                    return
                    //print(json)
                    
                    //let controller = FavorisViewController()
                    //self.navigationController?.pushViewController(controller, animated: true)
                }
                if let error = json["error"] as? String{
                    print(error)
                    //completion(.Error("errors are present", 401))
                    completion(nil)
                    return
                }
                guard let individual = self.individualFromDictionary(json) else{
                    //completion(.Error("error creating individual", 401))
                    completion(nil)
                    return
                }
                //completion(.Success(individual))
                completion(individual)
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
