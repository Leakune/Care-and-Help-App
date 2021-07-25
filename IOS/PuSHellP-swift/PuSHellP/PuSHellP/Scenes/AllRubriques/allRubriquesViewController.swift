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
                    Utils.displayAlertDialog(viewController: self, message: errorMessage)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        self.tableViewSections.dataSource = self
        self.tableViewSections.delegate = self
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
//            let fileName : String = srcIcon
//            let fileNameArr : [String] = fileName.components(separatedBy: ".")
//            let fileExtension = fileNameArr[1]
//            print("filename: " + fileNameArr[0])
//            print("file extension: " + fileExtension)
//            if let filePath = Bundle.main.path(forResource: "http://0.0.0.0:3000/uploads/" + fileNameArr[0], ofType: fileExtension), let image = UIImage(contentsOfFile: filePath) {
//                cell.imageView?.contentMode = .scaleAspectFit
//                cell.imageView?.image = image
//            }
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
        print(section.getTitle() + "clicked")
    }
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let section = self.listSections[sourceIndexPath.row]
//        self.listSections.remove(at: sourceIndexPath.row)
//        self.listSections.insert(section, at: destinationIndexPath.row)
//    }
}
