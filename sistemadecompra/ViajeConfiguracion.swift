//
//  ViajeConfiguracion.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/12/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData

class ViajeConfiguracion: UIViewController, UITextFieldDelegate {
    
    var userD = UserDefaults.standard
    var fueEditado = false
    var viajeCompare = String()
    
    @IBOutlet weak var viaje: UITextField!
    @IBOutlet weak var tazaUsd: UITextField!
    @IBOutlet weak var tazaRmb: UITextField!
    @IBOutlet weak var flete: UITextField!
    @IBOutlet weak var ganancia: UITextField!
    @IBOutlet weak var aduanaMasGastos: UITextField!
    @IBOutlet weak var itebis: UITextField!
    @IBOutlet weak var selecivo: UITextField!
    
    @IBOutlet weak var material: UITextField!
    @IBOutlet var colores: [UIButton]!
   
    @IBOutlet weak var salarioXHora: UITextField!
    @IBOutlet weak var editarviajeoutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////  get TAZA ONLINE
        
        tazaRmb.text = rmb
        tazaUsd.text = rd
        if let viaj  = userD.object(forKey: "viajeactual") {
            viajeCompare = "\(viaj)"
        }
        if viajeCompare == "" {
            editarviajeoutlet.isHidden = true
        } else {
             editarviajeoutlet.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func botCancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "Viaje2Menu", sender: self)
    }
    
    
    @IBAction func seleccolores(_ sender: UIButton) {
        colores.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
        
        
        
    }
    
    enum colores1: String {
        case rojo = "ROJO"
        case rosado = "ROSADO"
        case azul = "AZUL"
        case negro = "NEGRO"
        case blanco = "BLANCO"
        case amarillo = "AMARILLO"
        case marron = "MARRON"
        case verde = "VERDE"
    }
    
        
    @IBAction func colortap(_ sender: UIButton) {
        guard let title = sender.currentTitle, let col = colores1(rawValue: title) else {
            return
        }

        switch col {
        case .rojo:
            print("rojo")
        case .rosado:
            print("rosado")
        case .azul:
            print("azul")
        case .negro:
            print("Negro")
        case .blanco:
            print("Blanco")
        case .amarillo:
            print("Amarillo")
        case .marron:
            print("Marron")
        default:
            print("Verde")
            
        }

    }

    
    @IBAction func botSalvar(_ sender: Any) {
       
            
        if viaje.text != "" && tazaUsd.text != "" && tazaRmb.text != "" && flete.text != "" && ganancia.text != "" && aduanaMasGastos.text != "" && itebis.text != "" && selecivo.text != "" && material.text != "" && salarioXHora.text != "" {
        
         if !fueEditado {
        let nomviaje: String = String(describing: Viaje.self)
        
        let via:Viaje = NSEntityDescription.insertNewObject(forEntityName: nomviaje , into: DatabaseController.getContext()) as! Viaje
        
      
            
      
        via.nombreDelViaje = viaje.text
        via.tazaUsd = Double(tazaUsd.text!)!
        via.tazaRmb = Double(tazaRmb.text!)!
        via.fleteMaritimo = Double(flete.text!)!
        via.ganaciaGeneral = Double(ganancia.text!)!
        via.materialRelleno = Double(material.text!)!
        via.salarioxhora = Double(salarioXHora.text!)!
        via.aduanaMasGastos = Double(aduanaMasGastos.text!)!
        via.impuestoItebis = Double(itebis.text!)!
        via.selectivo = Double(selecivo .text!)!
       
        print("SALVADO")
            
            userD.set(tazaRmb.text, forKey: "ultimataza")
            userD.set(tazaUsd.text, forKey: "ultimatazard")
            userD.set(viaje.text, forKey: "viajeactual")
            userD.synchronize()
    
           userD.set(viaje.text, forKey: "nombreDelViaje")
            userD.set(true, forKey: "ultimoViaje")
            userD.synchronize()
            
            DatabaseController.saveContext()
           
        } else { // NO fue editado if END EXISTE
          
            
            do {
                let searchresult = try DatabaseController.getContext().fetch(fetchRequestVia)
                
                for via1 in searchresult as [Viaje] {
                    if via1.nombreDelViaje == viajeCompare {
                        
                        via1.nombreDelViaje = viaje.text
                        via1.tazaUsd = Double(tazaUsd.text!)!
                        via1.tazaRmb = Double(tazaRmb.text!)!
                        via1.fleteMaritimo = Double(flete.text!)!
                        via1.ganaciaGeneral = Double(ganancia.text!)!
                        via1.materialRelleno = Double(material.text!)!
                        via1.salarioxhora = Double(salarioXHora.text!)!
                        via1.aduanaMasGastos = Double(aduanaMasGastos.text!)!
                        via1.impuestoItebis = Double(itebis.text!)!
                        via1.selectivo = Double(selecivo .text!)!
                    
                        DatabaseController.saveContext()
                        
                        
                    }
                }
                
            } catch {
                print("Error")
            }
            
         
            }  // end editar true
            
            dismiss(animated: true, completion: nil)
            
        } // end if condition
      
        
   }
    
   /////////////////// EDITAR VIAJE  ////////
    
    @IBAction func editarViajeBotton(_ sender: UIButton) {
        fueEditado = true
//        viajeCompare = String()
        
        if let viaj  = userD.object(forKey: "viajeactual") {
            viajeCompare = "\(viaj)"
        }
        if viajeCompare == "" {
    
        }
        
        
        do {
            let searchresult = try DatabaseController.getContext().fetch(fetchRequestVia)
          
            for via1 in searchresult as [Viaje] {
                if via1.nombreDelViaje == viajeCompare {
                    
                    viaje.text = via1.nombreDelViaje
                    tazaUsd.text = "\(via1.tazaUsd)"
                    tazaRmb.text = "\(via1.tazaRmb)"
                    flete.text = "\(via1.fleteMaritimo)"
                    ganancia.text = "\(via1.ganaciaGeneral)"
                    material.text = "\(via1.materialRelleno)"
                    salarioXHora.text = "\(via1.salarioxhora)"
                    aduanaMasGastos.text = "\(via1.aduanaMasGastos)"
                    itebis.text = "\(via1.impuestoItebis)"
                    selecivo.text = "\(via1.selectivo)"

                    
                    
                    
                    
                }
                
                
            }
            
        } catch {
            print("Error")
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func atrasbutton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
        
//         performSegue(withIdentifier: "Viaje2Menu", sender: self)
    }
    
    
    // BODY
}
