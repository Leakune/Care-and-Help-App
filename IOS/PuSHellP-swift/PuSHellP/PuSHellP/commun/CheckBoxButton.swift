//
//  CheckBoxButton.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 28/07/2021.
//

import Foundation
import UIKit
class CheckBoxButton: UIView {
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
