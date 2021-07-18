//
//  allRubriquesViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 06/06/2021.
//

import UIKit

class allRubriquesViewController: UIViewController {
    public var individual: Individual?
    static func newInstance(individual: Individual) -> allRubriquesViewController{
        let controller = allRubriquesViewController()
        controller.individual = individual
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonReturnFavoris(_ sender: Any) {
        print(individual!.description)
        let controller = FavorisViewController.newInstance(individual: individual!)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
