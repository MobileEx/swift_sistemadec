//
//  CustomCell.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/22/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
protocol CustomCellDelegate {
    func cellButtonTapped(data: Int)
}
public var Reftemp = String()

class CustomCell: UITableViewCell {

        
    @IBOutlet weak var imgRef: UIImageView!
    
    @IBOutlet weak var refer: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var historico: UIButton!
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var ppv: UILabel!
    @IBOutlet weak var nombreFoto: UILabel!
    
    @IBOutlet weak var detalleHistorico: UITextView!
    
    @IBOutlet weak var viewfortable: UIView!
    
    var delegate: CustomCellDelegate?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
   
    
    @IBAction func historytap(_ sender: Any) {
                if delegate != nil {
                 
        //            self.delegate?.cellButtonTapped(sender: self as! CustomCellDelegate)
                   
                    self.delegate?.cellButtonTapped(data: historico.tag)
                    viewfortable.isHidden = false

                    
                    
                    detalleHistorico.text = "      FECHA       N.PEDIDO   C.CAJAS    CAJAS  C.TOTAL  PRECIO"
                    do {
                        let searchresult = try DatabaseController.getContext().fetch(fetchRequestHis)
                        for resu in searchresult as [Pedidohistorico] {
                    
                            if Reftemp == resu.referencia {
                                
                              detalleHistorico.text = detalleHistorico.text + "\n\(resu.fecha!)         \(resu.numerodepedido!)            \(resu.cantidadencaja!)                 \(resu.cajas!)           \(resu.cantidadtotal!)          \(resu.moneda!)\(resu.precio!)"
                                
                            }
                            
                            
                            
                        }
                        
                        
                    } catch {
                        print("error")
                    }
                    
                    
                    
                    
                    
        
                }
        
    }
 
}

