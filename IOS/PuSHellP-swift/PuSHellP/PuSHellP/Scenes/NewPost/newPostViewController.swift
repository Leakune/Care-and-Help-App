//
//  newPostViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 06/06/2021.
//

import UIKit

class newPostViewController: UIViewController {
    
    public var individual: Individual?
    public var listSections: [Section] = []
    public var sectionSelectd: Section?
    var pickerSection = UIPickerView()
    
    @IBOutlet var textSection: UITextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    //@IBOutlet var pickerSection: UIPickerView!
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textPostContent: UITextView!
    @IBOutlet var imageSection: UIImageView!
    
    static func newInstance(individual: Individual) -> newPostViewController{
        let controller = newPostViewController()
        controller.individual = individual
        return controller
    }
    override func viewWillAppear(_ animated: Bool) {
        RequestGetSections.requestGetSections(spinner: self.spinner) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(let sections):
                    self.listSections = sections
                    print(self.listSections)
                    //self.pickerSection.reloadData()
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Création d'un nouveau poste"
        
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        
        self.pickerSection.delegate = self
        self.pickerSection.dataSource = self
        
        textSection.inputView = pickerSection
        textPostContent.delegate = self
        //textPostContent.textColor = UIColor.lightGray
        //textPostContent.font = .systemFont(ofSize: 24)
    }
    
   
    @IBAction func onClickPublish(_ sender: Any) {
        guard let title = self.textTitle.text, let content = self.textPostContent.text, let section = self.sectionSelectd else{
            Utils.displayAlertDialog(viewController: self, title: "Error", message: "Please fill all the fields.")
            return
        }
        RequestCreatePost.requestCreatePost(spinner: self.spinner, title: title, content: content, idSection: section.getId()) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(_):
                    Utils.displayAlertDialogWithPop(viewController: self, title: "Success", message: "The creation of the post has been successful")
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    

}
extension newPostViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textPostContent.textColor == UIColor.lightGray {
            textPostContent.text = ""
            textPostContent.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if textPostContent.text == "" {
            textPostContent.text = "Ecrire quelque chose..."
            textPostContent.textColor = UIColor.lightGray
        }
    }
}

extension newPostViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listSections.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listSections[row].getTitle()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let section = self.listSections[row]
        self.sectionSelectd = section
        self.textSection.text = self.listSections[row].getTitle()
        self.textSection.resignFirstResponder()
        if let srcIcon = section.getSrcIcon(){
            if let data = NSData(contentsOf: URL(string:"http://0.0.0.0:3000/uploads/sections/" + srcIcon)!)
            {
                self.imageSection.image = UIImage(data: data as Data)
            }
        }else{
            self.imageSection.isHidden = !self.imageSection.isHidden
        }
    }
}


