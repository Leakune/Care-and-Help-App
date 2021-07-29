//
//  CommentaryTableViewCell.swift
//  PuSHellP
//
//  Created by Ludovic FAVIER on 29/07/2021.
//

import UIKit

class CommentaryTableViewCell: UITableViewCell {

    @IBOutlet var pseudoUser: UILabel!
    @IBOutlet var dateCreation: UILabel!
    @IBOutlet var message: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
