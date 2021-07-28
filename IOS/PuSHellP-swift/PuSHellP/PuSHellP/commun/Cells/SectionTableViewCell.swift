//
//  SectionTableViewCell.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 28/07/2021.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet var imageSection: UIImageView!
    @IBOutlet var titleSection: UILabel!
    @IBOutlet var checkSection: CheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
