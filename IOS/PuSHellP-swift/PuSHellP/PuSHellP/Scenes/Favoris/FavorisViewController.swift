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
        print(self.individual!.description)

        // Do any additional setup after loading the view.
    }


    @IBAction func buttonRubrique(_ sender: Any) {
        let controller = allRubriquesViewController.newInstance(individual: individual!)
        
        self.navigationController?.pushViewController(controller, animated: true)                //self.navigationController?.pushViewController(allRubriquesViewController, animated: true)
    }
    @IBOutlet var tabBarPost: UITabBar!
    // ajouter la conexion avec la Tab bar
    //let controller = newPostViewController()
       // self.navigationController?.pushViewController(controller, animated: true)
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
