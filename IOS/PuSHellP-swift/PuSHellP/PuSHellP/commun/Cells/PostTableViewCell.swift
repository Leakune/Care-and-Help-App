//
//  PostTableViewCell.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 28/07/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
