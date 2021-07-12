//
//  ViewController.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/11/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData
var globalArray = [String]()
class ViewController: UIViewController {

    var userD1 = UserDefaults.standard
  
    
  
    @IBOutlet weak var Continuar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
          
        userD1.set(0, forKey: "indexpath") // clear save row avoid crash
                userD1.synchronize()
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
      
        
        if let sv = UserDefaults.standard.object(forKey: "fuesalvado") as? Bool {
            
            if sv == true {
               
                 self.performSegue(withIdentifier: "Bienvenidos2Menu", sender: self)
                  
                
            }
            
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func configuracionBoton(_ sender: Any) {
           
            self.performSegue(withIdentifier: "Bienvenidos2Configuracion", sender: self)
     
        
    }
    

}

