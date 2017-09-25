//
//  UserTVCell.swift
//  Assignment
//
//  Created by Sushobhit_BuiltByBlank on 9/25/17.
//  Copyright © 2017 Sushobhit Jain. All rights reserved.
//

import UIKit

class UserTVCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var activityIndV: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        if let spinner = self.activityIndV {
            spinner.startAnimating()
        }
    }
        
}
