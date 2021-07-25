//
//  allRubriquesViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 06/06/2021.
//

import UIKit

class allRubriquesViewController: UIViewController {
    public var individual: Individual?
    public var listSections: [Section] = []
    @IBOutlet var tableViewSections: UITableView!

    static func newInstance(individual: Individual) -> allRubriquesViewController{
        let controller = allRubriquesViewController()
        controller.individual = individual
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSections.delegate = self
        tableViewSections.dataSource = self
        RequestGetSections.requestGetSections { result in
            DispatchQueue.main.async {
                switch result{
                case .Success(let sections):
                    self.listSections = sections
                    self.tableViewSections.reloadData()
                case .Error(let errorMessage, _):
                    Utils.displayAlertDialog(viewController: self, message: errorMessage)
                }
            }
        }
    }

}
extension allRubriquesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listSections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.listSections[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectionId") else {
            return UITableViewCell(style: .default, reuseIdentifier: "sectionId")
        }
        cell.textLabel?.text = section.getTitle()
        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.image = image
        }
        return cell
    }
}
extension allRubriquesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.listSections[indexPath.row]
        print(section.getTitle() + "clicked")
    }
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let section = self.listSections[sourceIndexPath.row]
//        self.listSections.remove(at: sourceIndexPath.row)
//        self.listSections.insert(section, at: destinationIndexPath.row)
//    }
}
