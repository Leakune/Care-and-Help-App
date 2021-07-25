//
//  Utils.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 25/07/2021.
//
import UIKit
import Foundation

class Utils{
    public static func displayAlertDialog(viewController: UIViewController,message: String) -> Void{
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
          alertStyle = UIAlertController.Style.alert
        }
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: alertStyle)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        let popover = alert.popoverPresentationController
        popover?.permittedArrowDirections = [] //to hide the arrow of any particular direction
        viewController.present(alert, animated: true, completion: nil)
        return
    }
}
