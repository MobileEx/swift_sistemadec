//
//  ListaDePedidos.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/12/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit

class ListaDePedidos: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var myDict = [String:String]()
    var myArray = [[String:String]]()
    var count = 0
    var existe = false
    var checkedPedido = Int32()
    var set = 1
    var suplidor = String()
    var chkped = String()
    var arrayOrders = [String]()
    var intpedido =  Int32()
    var max: String?
    var factoryBOOL = Bool()
    var commingback = false
    
    
    @IBOutlet weak var labelNumeroPedido: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if commingback {
            myDict = [String:String]()
            myArray = [[String:String]]()
            count = 0
            existe = false
            checkedPedido = Int32()
            set = 1
            suplidor = String()
            chkped = String()
            arrayOrders = [String]()
            intpedido =  Int32()
            factoryBOOL = Bool()
            commingback = false
            getdata()
            tableview.reloadData()
            
        }
        
    }
    
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        // Do any additional setup after loading the view.
    }

    
    func getdata() {
        
        arrayOrders = []
        
        ///
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
            
            print("number of results: \(searchResults.count)")
            
            
            if searchResults.count > 0 {
                
                for result in searchResults as [Configuracion]{
                    
                    
                    if result.tipo == "principal" {
                        
                        
                        
                        
                        intpedido = result.secuenciaPedido
                        labelNumeroPedido.text = String("PEDIDO: \(intpedido) ACTUAL")
                        
                    }
                }
                
            }
        } catch {
            print ("Error")
            
        }
        
        
        ///
        
        do {
            let searchResultsDetalle = try DatabaseController.getContext().fetch(fetchRequestDet)
            
            //  print("Result of VIAJES: \(searchResultsViaje.count
            
            for resultv in searchResultsDetalle as [Detalle] { //LOOP
                
                
                if checkedPedido != resultv.numeroDePedido {
                    
                    if resultv.numeroDePedido > 0 {
                        
                        
                        
                        
                        
                        // buscar cuantas referecnias perteneciente a este DETALLE/PEDIDO
                        
                        //                       Add Predicate Working PErfect
                        let predicate = NSPredicate(format: "ANY det.numeroDePedido == %@", "\(resultv.numeroDePedido)")
                        fetchRequestRef.predicate = predicate
                        
                        
                        
                        
                        do {
                            let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
                            print("Cantidad de Referencia en \(resultv.numeroDePedido) es: \(searchResultRef.count)" )
                            
                            
                            count = searchResultRef.count
                            
                            
                            var cn = 0
                            for resu in searchResultRef as [Referencia] {
                                if cn <= 0 {
                                    if resu.fabrica == true  {    // si la referecnia es una fabrica
                                        
                                        
                                        suplidor = resu.suplidor!
                                    }
                                    else {
                                        suplidor = "General"
                                    }
                                    
                                    
                                    
                                    cn += 1
                                } // cn IF
                            }
                            
                            
                            
                            
                            
                        }catch {
                            
                        }
                        
                        
                        myDict["numerodepredido"] = "\(resultv.numeroDePedido)"
                        myDict["cantidadtotal"] = "\(resultv.cantidadTotal)"
                        myDict["cajas"] = "\(resultv.cantidaDecajas)"
                        myDict["ppv"] = "\(resultv.precioDeVenta)"
                        myDict["conteo"] = "\(count)"
                        
                        myDict["suplidor"] = suplidor
                        myArray.append(myDict)
                        print("PEDIDO CHECKIADO \(checkedPedido)")
                        
                        
                        checkedPedido = resultv.numeroDePedido
                        
                    }
                    
                } // end IF not the same
                
            } // end loop
            
            
            print(myArray)
        } catch{
            print("Error: \(error)")
            
        }
        
        
        
        
        
        
        print(myArray)
        
        
    }
    
    
    
    func chekiarUltimoPedido() -> String {
        var srt = String()
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
            
            print("number of results: \(searchResults.count)")
            
            
            if searchResults.count > 0 {
                
                for result in searchResults as [Configuracion] {
                    
                    
                    if result.tipo == "principal" {
                        
                        
                     
                           srt = String("\(result.secuenciaPedido)")
                    
                       
                    }
                }
            }
            
                
        } catch {
            print ("Error")
            
        }
        
        
        
        return srt
        
        
        
    }
    
    
    
    
    
    
    @IBAction func regresarApedidoBottun(_ sender: UIButton) {
        //////////
     var prednum = String()
        
     prednum = chekiarUltimoPedido()
        print(prednum)
   
        UserDefaults.standard.set(prednum, forKey: "customPedido")
        
        UserDefaults.standard.synchronize()
        
    }
    
    
    @IBAction func crearpedidonuevo(_ sender: Any) {
   ////
        
        let refreshAlert = UIAlertController(title: "ESTA SEGURO DE CREAR UN                 PEDIDO NUEVO", message: """
                                                                                     
                                                                                     
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "SI", style: .cancel, handler: { (action: UIAlertAction!) in
          
            print("SI, FUE SELECCIONADO")
            sumarpedido()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
           
            print("NO, FUE SELECIONADO")
                    return
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        

        
        
        
        
        func sumarpedido() {
    
        arrayOrders.append("\(intpedido)")
        
       max = arrayOrders.max()
        
     
//        print("\(max)")
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)

            print("number of results: \(searchResults.count)")


            if searchResults.count > 0 {

                for result in searchResults as [Configuracion]{


                    if result.tipo == "principal" {


                        if Int32(max!) == result.secuenciaPedido {

                            result.secuenciaPedido += 1
                            UserDefaults.standard.set(nil, forKey: "customPedido")
                            
                            UserDefaults.standard.synchronize()
                        }


                        DatabaseController.saveContext()
                        let tempmax = Int32(max!)! + 1
                   labelNumeroPedido.text = String("PEDIDO: \(tempmax) ACTUAL")
                     viewDidLoad()
                        
                    }
                }

            }
        } catch {
            print ("Error")

        }
        } // end sumapedido
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
   let client = myArray[myArray.count - 1 - indexPath.row]
 
        chkped = client["numerodepredido"]!
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
       

        cell.textLabel?.text = "EL PEDIDO NUMERO: \(client["numerodepredido"]!) " + " TIENE " + client["conteo"]! + "  REFERENCIAS   " + "SUPLIDOR : \(client["suplidor"]!)"
        cell.detailTextLabel?.text = "HELLO"//client["ppv"]
        
        arrayOrders.append(chkped)
        
        return cell
    }
    
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    set = 2
    let arrayPedido = myArray[myArray.count - 1 - indexPath.row]
    
    
    let comparePedido = arrayPedido["numerodepredido"]!
    
   
   tableView.deselectRow(at: indexPath, animated: true)
    
    performSegue(withIdentifier: "listaPedido2Pedido", sender: comparePedido)
    
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if set == 2 {
            let guest = segue.destination as! DetallePedido
            guest.secPedido  = sender as! String


        } else {

        }
        
        
    }

    
    
    
    
    @IBAction func backbuttonmenu(_ sender: Any) {
        
//        if let presenter = self.presentingViewController as? Menua {
//            presenter.set = 0
//
//        }
        if let presenter = self.presentingViewController as? Menua {
            presenter.set = 1
            presenter.wasnewsaved = true
            presenter.comingback2M = true
//
            
        }
        
        self.dismiss(animated: true, completion: nil)

        
        
   
//        performSegue(withIdentifier: "listaPedido2Menu", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let arrayPedido = myArray[myArray.count - 1 - indexPath.row]
        let comparePedido2 = arrayPedido["numerodepredido"]!
        return "BORRAR PEDIDO \(comparePedido2)"
    }
    
    
    // delete row with a swip
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //  let compareReferencia = refArray1[refArray1.count - 1 - indexPath.row].name
           
          //////////////////////////
            do {
                let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
                
                print("number of results: \(searchResults.count)")
                
                
                if searchResults.count > 0 {
                    
                    for result in searchResults as [Configuracion]{
                        
                        
                        if result.tipo == "principal" {
                            
                            
                            
                            
                            intpedido = result.secuenciaPedido
                            
                            UserDefaults.standard.set(intpedido, forKey: "customPedido")
                            
                            UserDefaults.standard.synchronize()
                            
                            
                            
                        
                            
                            
//                            labelNumeroPedido.text = String("PEDIDO: \(intpedido) ACTUAL")
                            
                            
                        }
                    }
                    
                }
            } catch {
                print ("Error")
                
            }
            
       ///////////////////////////////////////
            
            
            
            
            
            
            
            
            
            
            let arrayPedido = myArray[myArray.count - 1 - indexPath.row]
            
            
            let comparePedido = arrayPedido["numerodepredido"]!

            myArray.remove(at: myArray.count - 1 - indexPath.row)
            
            tableview.deleteRows(at: [indexPath], with: .fade)
            
            
            print("PEDIDO A BORRAR ES : \(comparePedido)")
            
            do {
                let searchresult9 = try DatabaseController.getContext().fetch(fetchRequestDet)
                for result9 in searchresult9 as [Detalle] {
                    if result9.numeroDePedido == Int32(comparePedido)! {
                        DatabaseController.getContext().delete(result9)
                        DatabaseController.saveContext()
                        
                        ///  TRABJAR CUANDO BORRAS ACTUAL CREE UNO CUANDO BORRAS UNPEDIDO Y ESTAS TRABAJNDO CONEL QUE SELECTIONE EL ULTIMO
                    }
                    
                }
                
            } catch {
                
            }
            
        } // End IF Delete
    }

    
    
    
    
    
}


   
    
    
    
//    let refreshAlert = UIAlertController(title: "AVISO IMPORTANTE: \(result1.secuenciaPedido)", message: """
//    Se a Creado el PEdido                                                     Numero
//    """, preferredStyle: UIAlertControllerStyle.alert)
//
//
//    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
//
//    print("OK, FUE SELECCIONADO")
//
//    }))
//    present(refreshAlert, animated: true, completion: nil)
    
   
    
    
    

