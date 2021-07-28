//
//  allRubriquesViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 06/06/2021.
//

import UIKit

class allRubriquesViewController: UIViewController {
    @IBOutlet var spinner: UIActivityIndicatorView!
    public var individual: Individual?
    public var listSections: [Section] = []
    @IBOutlet var tableViewSections: UITableView!

    static func newInstance(individual: Individual) -> allRubriquesViewController{
        let controller = allRubriquesViewController()
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
                    self.tableViewSections.reloadData()
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, title: "Error", message: errorMessage)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Liste des rubriques"
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        self.tableViewSections.dataSource = self
        self.tableViewSections.delegate = self
    }

    @IBAction func onClickPost(_ sender: Any) {
        let controller = newPostViewController.newInstance(individual: individual!)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension allRubriquesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.listSections[indexPath.row]
        let cell = getSectionCell(tableView: tableView)
        cell.textLabel?.text = section.getTitle()
        if let srcIcon = section.getSrcIcon(){
            if let data = NSData(contentsOf: URL(string:"http://0.0.0.0:3000/uploads/sections/" + srcIcon)!)
            {
                cell.imageView?.image = UIImage(data: data as Data)
            }
        }
        return cell
    }
    func getSectionCell(tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "section_identifier") else {
            return UITableViewCell(style: .default, reuseIdentifier: "section_identifier")
        }
        return cell
    }
}
extension allRubriquesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.listSections[indexPath.row]
        guard let user = self.individual else{
            return
        }
        let controller = rubriqueViewController.newInstance(individual: user, section: section)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
