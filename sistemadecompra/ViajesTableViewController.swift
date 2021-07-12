//
//  ViajesTableViewController.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/8/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViajesTableViewController: UITableViewController {

    var myDict = [String:String]()
    var myArray = [[String:String]]()
    var count = 0
    var transfvia = String()
    var userD = UserDefaults.standard
    var viajearray = [String]()
    var misviaArray = [String]()
    var ultimoviaje:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableview.dataSource = self
//        tableview.delegate = self
        // Do any additional setup after loading the view.
        
     //
        do {
            let searchResultsViaje = try DatabaseController.getContext().fetch(fetchRequestVia)
            
            //  print("Result of VIAJES: \(searchResultsViaje.count)")
            
            for resultv in searchResultsViaje as [Viaje] {
                
                if resultv.nombreDelViaje != nil {
                    
                    // buscar cuantas referecnias perteneciente a este viaje
                    
                    //   Add Predicate Working PErfect
                    let predicate = NSPredicate(format: "ANY via.nombreDelViaje == %@", "\(resultv.nombreDelViaje!)")
                    fetchRequestRef.predicate = predicate
                    
                    
                    
                    
                    do {
                        let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
                        //    print("Cantidad de referencia en \(resultv.nombreDelViaje) es: \(searchResultRef.count)" )
                        
                        count = searchResultRef.count
                        
                        
                    }catch {
                        
                    }
                    
                    
                    myDict["nombreviaje"] = "\(resultv.nombreDelViaje!)"
                    myDict["tazausd"] = "\(resultv.tazaUsd)"
                    myDict["tazarmb"] = "\(resultv.tazaRmb)"
                    myDict["flete"] = "\(resultv.fleteMaritimo)"
                    myDict["aduana"] = "\(resultv.aduanaMasGastos)"
                    myDict["itebis"] = "\(resultv.impuestoItebis)"
                    myDict["selectivo"] = "\(resultv.selectivo)"
                    myDict["relleno"] = "\(resultv.materialRelleno)"
                    myDict["conteo"] = "\(count)"
                    myDict["manoObra"] = "\(resultv.salarioxhora)"
                    
                    myArray.append(myDict)
                    
                   
                    misviaArray.append(myDict["nombreviaje"]!)
                }
                
            }
           
            
        } catch{
            print("Error: \(error)")
        }
       
        self.tableView.sectionHeaderHeight = 20
      
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        let label = UILabel(frame: CGRect(x: 270, y: 5, width: 200, height: 50))
        
        
        label.text = "TOTAL DE VIAJES: \(myArray.count)"
        label.textColor = UIColor.black
        
        self.view.addSubview(label)
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if misviaArray.isEmpty == true {
            print("TOTAL DE ENTRADAS SON: \(misviaArray.count)")
            performSegue(withIdentifier: "ListaViaje2Menu", sender: self)
            
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let client = myArray[indexPath.row]
        
     //   let imgItem = imageItemArray[indexPath.row]
        
        
        
        

        
        cell.textLabel?.text = "\(client["nombreviaje"]!)    Tiene \(client["conteo"]!)    Referencias "
        
        //    "\(client.objectForkey("tazausd"))"
      
                
        viajearray.append(client["nombreviaje"]!)
        
        //nunca se uso
//        if let info = userD.object(forKey: "viajeactual") as? String {
//
//
//
//        }
        
//        var ed =  String(format: "%.2f", arguments: [Double(client["tazarmb"]!)!])
       
        
        cell.detailTextLabel?.text = "Taza Usd: " + String(format: "%.2f", arguments: [Double(client["tazausd"]!)!]) + "   Taza Rmb: " +  String(format: "%.2f", arguments: [Double(client["tazarmb"]!)!]) + "   Flete: % \(client["flete"]!)  Aduana + Gastos: % \(client["aduana"]!)    Itebis: % \(client["itebis"]!)    Selectivo: % \(client["selectivo"]!)    Relleno: $ \(client["relleno"]!) Salario x Hora: $ \(client["manoObra"]!)"
        // Configure the cell... NSDictionary *projects = [[json objectAtIndex:0] objectForKey:@"name"];
//userD.set("\(client["tazarmb"]!)", forKey: "ultimataza")
//        userD.synchronize()
        
        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        transfvia = viajearray[indexPath.row]
     userD.set("\(transfvia)",forKey: "nombreDelViaje")
        
        if transfvia == misviaArray.last {
          let fg = "\(misviaArray.last!)"
            
            
            userD.set(fg, forKey: "viajeactual")
            userD.synchronize()
            
        userD.set(true, forKey: "ultimoViaje")
            userD.synchronize()
        } else {
            userD.set(false, forKey: "ultimoViaje")
            userD.synchronize()
        }
        
        userD.synchronize()
            dismiss(animated: true, completion: nil)
//          performSegue(withIdentifier: "ListaViaje2Menu", sender: self)
        
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
 

        }
    
   
    
    
    
}


