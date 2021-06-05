//
//  homeViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 30/04/2021.
//

import UIKit

class homeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTextFieldManager()
        // Do any additional setup after loading the view.
    }
    // MARK: Outlets
   
    
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var motDePasseTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submit(_ sender: Any) {
    
    
        let pseudo = self.pseudoTextField.text ?? ""
        let motDePasse = self.motDePasseTextField.text ?? ""
        guard pseudo.count > 0,
            motDePasse.count > 0
            else {
                let alert = UIAlertController(title: "Erreur", message: "Champs obligatoires", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
                //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

                let parameters = ["username": pseudo, "password": motDePasse]

                //create the url with URL
                let url = URL(string: "http://0.0.0.0:3000/login")!

                //create the session object
                let session = URLSession.shared

                //now create the URLRequest object using the url object
                var request = URLRequest(url: url)
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

                    guard error == nil else {
                        return
                    }

                    guard let data = data else {
                        return
                    }

                    do {
                        //create json object from data
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                            print(json)
                            // handle json...
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                })
                task.resume()
            }
    }

   
   
    // MARK: Private function
//    private func setupTextFieldManager(){
//        PseudoTextField.delegate = self
//        MotDePasseTextField.delegate = self
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
//    }
    //MARK: Action
//    @objc private func hideKeyboard() {
//        PseudoTextField.resignFirstResponder()
//        MotDePasseTextField.resignFirstResponder()
//    }
    
    
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
//extension homeViewController: UITextFieldDelegate {
//func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//textField.resignFirstResponder()
//return true
//    }
//
//}
