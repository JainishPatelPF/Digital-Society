//
//  ownersettingstab.swift
//  Digital Society
//
//  Created by jainish on 22/01/19.
//  Copyright © 2019 jainish. All rights reserved.
//

import UIKit

class ownersettingstab: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        imageview.layer.cornerRadius = imageview.layer.frame.width / 2
        imageview.clipsToBounds = true
        // Configure the view for the selected state
    }

}
