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
    public var listCommentary: [Commentary] = []
    public var isUserDidPushThePost: Bool?
    public var cellCommentaries = "CommentaryTableViewCell"
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
                    RequestGetCommentaries.requestGetCommentariesByIdPost(spinner: self.spinner, idPost: post.getId()) { result in
                        DispatchQueue.main.async {
                            self.spinner.stopAnimating()
                            switch result{
                            case .Success(let commentaries):
                                self.listCommentary = commentaries
                                self.listCommentaries.reloadData()
                            case .Error(let errorMessage, _):
                                Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                            }
                        }
                    }
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    func loadData() {
        self.listCommentaries.reloadData()
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
        self.listCommentaries.register(UINib.init(nibName: cellCommentaries, bundle: nil), forCellReuseIdentifier: cellCommentaries)
        self.listCommentaries.dataSource = self
        self.listCommentaries.delegate = self
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
        guard let text = self.textCommentary.text, let user = self.individual, let post = self.post else{
            Utils.displayAlertDialog(viewController: self, title: "Error", message: "Please fill the text commentary field.")
            return
        }
        RequestCommentary.requestCreateCommentaryPost(spinner: self.spinner, text: text, idUser: user.getId(), idPost: post.getId()) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(_):
                    Utils.displayAlertDialogWithRefresh(viewController: self, title: "Success", message: "The creation of the commentary has been successful", tableView: self.listCommentaries)
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    @IBAction func onClickAbandonCommentary(_ sender: Any) {
        print("abandon clicked")
    }
}

extension postViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listCommentary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentary = self.listCommentary[indexPath.row]
        let cell = getCommentaryCell(tableView: tableView, userId: commentary.getIdUser(), commentary: commentary) as! CommentaryTableViewCell
        //cell.textLabel?.text = commentary.getText()
        return cell
    }
    func getCommentaryCell(tableView: UITableView, userId: Int, commentary: Commentary) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "CommentaryTableViewCell") as? CommentaryTableViewCell) else {
            return UITableViewCell(style: .default, reuseIdentifier: "CommentaryTableViewCell") as! CommentaryTableViewCell
        }
        RequestGetUserById.RequestGetUserById(spinner: self.spinner, idUser: userId) { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(let user):
                    cell.pseudoUser.text = user.getPseudo()
                    cell.dateCreation.text = commentary.getDatecreation()
                    cell.message.text = commentary.getText()
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
        return cell
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "section_identifier") else {
//            return UITableViewCell(style: .default, reuseIdentifier: "section_identifier")
//        }
//        return cell
    }


}
extension postViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentary = self.listCommentary[indexPath.row]
        print(commentary.getText() + " clicked")
    }
}
