//
//  rubriqueViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 05/06/2021.
//

import UIKit

class rubriqueViewController: UIViewController {
    public var individual: Individual?
    public var section: Section?
    public var listPost: [Post] = []
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var imageSection: UIImageView!
    @IBOutlet var listPosts: UITableView!
    /*required init?(coder: aDecoder: NSCoder) {
        super.init(coder: adCoder)
        tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "User—Icone"), tag: 1)
    }*/
    
    static func newInstance(individual: Individual, section: Section) -> rubriqueViewController{
        let controller = rubriqueViewController()
        controller.individual = individual
        controller.section = section
        return controller
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let section = self.section else{
            return
        }
        if let srcIcon = section.getSrcIcon(){
            if let data = NSData(contentsOf: URL(string:"http://0.0.0.0:3000/uploads/sections/" + srcIcon)!)
            {
                self.imageSection.image = UIImage(data: data as Data)
            }
        }else{
            self.imageSection.isHidden = !self.imageSection.isHidden
        }
        RequestGetPosts.requestGetPostsByIdSection(spinner: self.spinner, idSection: section.getId(), completion:{ result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                switch result{
                case .Success(let posts):
                    self.listPost = posts
                    print(self.listPost)
                    self.listPosts.reloadData()
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rubrique " + section!.getTitle()
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        self.listPosts.dataSource = self
        self.listPosts.delegate = self
    }

    @IBAction func onClickPost(_ sender: Any) {
        let controller = newPostViewController.newInstance(individual: individual!)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension rubriqueViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPost.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = self.listPost[indexPath.row]
        let cell = getPostCell(tableView: tableView)
        cell.textLabel?.text = post.getTitle()
        return cell
    }
    func getPostCell(tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "post_identifier") else {
            return UITableViewCell(style: .default, reuseIdentifier: "post_identifier")
        }
        return cell
    }


}

extension rubriqueViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.listPost[indexPath.row]
        print(post.getTitle() + " clicked")
//        guard let user = self.individual else{
//            return
//        }
//        let controller = rubriqueViewController.newInstance(individual: user, section: section)
//        self.navigationController?.pushViewController(controller, animated: true)
    }
}
