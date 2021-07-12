//
//  CustomCellInventario.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/11/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit

class CustomCellInventario: UITableViewCell {

    @IBOutlet weak var imgref: UIImageView!
    
        @IBOutlet weak var reflabel: UILabel!
    
    
    @IBOutlet weak var desclabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
