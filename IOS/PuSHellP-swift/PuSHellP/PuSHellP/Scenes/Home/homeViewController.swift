//
//  homeViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 30/04/2021.
//

import UIKit

class homeViewController: UIViewController {
   
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var pseudoTextField: UITextField!
    @IBOutlet var motDePasseTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
    }
    
    @IBAction func submitButton(_ sender: Any) {
        //self.displayLoading()
        let pseudo = self.pseudoTextField.text ?? ""
        let motDePasse = self.motDePasseTextField.text ?? ""
        guard pseudo.count > 0,
              motDePasse.count > 0
            else {
                let alert = UIAlertController(title: "Erreur", message: "Champs obligatoires", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        RequestConnexion.requestConnexion(spinner: self.spinner, pseudo: pseudo, password: motDePasse, completion:{ result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(let individual):
                    let controller = FavorisViewController.newInstance(individual: individual)
                    self.navigationController?.pushViewController(controller, animated: true)
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, message: errorMessage)
                }
            }
        })
    }
}
