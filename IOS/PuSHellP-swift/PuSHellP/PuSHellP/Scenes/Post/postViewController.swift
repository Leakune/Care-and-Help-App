//
//  postViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 09/06/2021.
//

import UIKit

class postViewController: UIViewController {
    public var individual: Individual?
    public var section: Section?
    public var post: Post?
    public var isUserDidPushThePost: Bool?
    public var colorPushed = UIColor.systemOrange
    public var colorUnpushed = UIColor.systemBlue
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var numberPush: UILabel!
    @IBOutlet var arrowPush: UIButton!
    @IBOutlet var titlePost: UITextField!
    @IBOutlet var contentPost: UITextView!
    @IBOutlet var textCommentary: UITextView!
    @IBOutlet var listCommentaries: UITableView!
    
    static func newInstance(individual: Individual, section: Section, post: Post) -> postViewController{
        let controller = postViewController()
        controller.individual = individual
        controller.section = section
        controller.post = post
        return controller
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let user = self.individual, let post = self.post else{
            return
        }
        RequestUserHasPost.requestGetIndividualsWithPostsByIds(spinner: self.spinner, idUser: user.getId(), idPost: post.getId()) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(let isUserDidPushThePost):
                    self.isUserDidPushThePost = isUserDidPushThePost == 1
                    if(self.isUserDidPushThePost!){
                        self.arrowPush.tintColor = self.colorPushed
                    }else{
                        self.arrowPush.tintColor = self.colorUnpushed
                    }
                
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        if let post = self.post{
            self.title = "Post: " + post.getTitle()
            self.titlePost.isEnabled = false
            self.numberPush.text = String(post.getNumberpush())
            self.titlePost.text = post.getTitle()
            self.contentPost.text = post.getContent()
        }
        
    }
    @IBAction func onClickPush(_ sender: Any) {
        guard let user = self.individual, let post = self.post else{
            return
        }
        RequestPushPost.pushPostByIdUserWithIdPost(spinner: self.spinner, idUser: user.getId(), idPost: post.getId()) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(let numberpush):
                    self.isUserDidPushThePost = !self.isUserDidPushThePost!
                    if(self.isUserDidPushThePost!){
                        self.arrowPush.tintColor = self.colorPushed
                    }else{
                        self.arrowPush.tintColor = self.colorUnpushed
                    }
                    self.numberPush.text = String(numberpush)
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    
    @IBAction func onClickAddCommentary(_ sender: Any) {
        print("add clicked")
    }
    @IBAction func onClickAbandonCommentary(_ sender: Any) {
        print("abandon clicked")
    }
}
