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
   
    
    @IBOutlet var pseudoTextField: UITextField!
    @IBOutlet var motDePasseTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
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
        let uri = "http://0.0.0.0:3000/login"
                
        RequestConnexion.requestConnexion(urlString: uri, pseudo: pseudo, password: motDePasse, completion:{ individual in
            DispatchQueue.main.async {
                //self.dismissLoading()
                //self.dismiss(animated: false, completion: nil)
                guard let idvl = individual else{
                    print("no individual created")
                    return
                }
                print(idvl.description)
                let controller = FavorisViewController.newInstance(individual: idvl)
                self.navigationController?.pushViewController(controller, animated: true)
            }
        })
    }
    
//    public func displayLoading(){
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating();
//
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
//    }
//    public func dismissLoading(){
//        if let vc = self.presentedViewController, vc is UIAlertController {
//            dismiss(animated: false, completion: nil)
//        }
//    }
    
                
    


   
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
}
