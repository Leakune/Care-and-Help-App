//
//  FavorisViewController.swift
//  PuSHellP
//
//  Created by MAC PAC on 05/06/2021.
//

import UIKit

class FavorisViewController: UIViewController {
    public var individual: Individual?
    
    static func newInstance(individual: Individual) -> FavorisViewController{
        let controller = FavorisViewController()
        controller.individual = individual
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favoris"
        print(self.individual!.description)

    }


    @IBAction func buttonRubrique(_ sender: Any) {
        let controller = allRubriquesViewController.newInstance(individual: individual!)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBOutlet var tabBarPost: UITabBar!
    // ajouter la conexion avec la Tab bar
    //let controller = newPostViewController()
       // self.navigationController?.pushViewController(controller, animated: true)
    
    @IBAction func onClickPost(_ sender: Any) {
        let controller = newPostViewController.newInstance(individual: individual!)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
