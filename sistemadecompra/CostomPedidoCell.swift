//
//  CostomPedidoCell.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/12/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit

class CostomPedidoCell: UITableViewCell {

    @IBOutlet weak var precio: UILabel!
    
    @IBOutlet weak var cajas: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var descr: UILabel!
    
    @IBOutlet weak var cantotal: UILabel!
   
    @IBOutlet weak var cantcaja: UILabel!
 
    @IBOutlet weak var totalusd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
