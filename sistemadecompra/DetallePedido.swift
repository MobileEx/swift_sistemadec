//
//  DetallePedido.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/12/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData
import Photos
import MessageUI
public var appendBool = Bool()

public var lastRmbRecorded = String()

class DetallePedido: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

   var secPedido = String()
    var myDict = [String:String]()
    var myArray = [[String:String]]()
    var myDict2 = [String:String]()
    var myArray2 = [[String:String]]()
    
    var predicate = NSPredicate()
    var count = 0
    var checkedPedido = Int32()
    var sumatotal: Double = 0.0
    var sumatotalRMB : Double = 0.0
    var set = 1
    var tranSecPed = String()
    var total = String()
    var vof = Bool()    // es precio en dolares true o false
    var temrem = Double()
    var delcon = Bool()
    var facto = String()
    var llevaEmpMad = String()
    var empSeparado = String()
    var Price = String()
    var notaconfirmacion = String()
    var colore = String()
    var moneda = String()
    var secpedido2 = String()
    var nomPed = String()
    var recuperarPed = String()
     var cdbSec = Int64()
    var tienecdb = Bool()
    var transferPedido = String()
    var regreso = Bool()
    var arrayhist = [[String:String]]()
    var dicHist = [String:String]()
    var idioma = Bool()
    var calle = String()
    var commingback = false
    var tt = String()
    var nombreArchivo = String()
    
    var sumCbm = Double()
   var refFound = false
    
    var transferHistoricoPedido = Bool()
    
    @IBOutlet weak var resultadoCbm: UILabel!
    
    
    @IBOutlet weak var nombrePedidoTf: UITextField!
    
    @IBOutlet weak var pedidonumLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var labeltotal: UILabel!
    
    @IBOutlet weak var switchIdioma: UISwitch!
    
    
    override func viewDidAppear(_ animated: Bool) {
     
        if idioma == true {
            switchIdioma.isOn = true
        } else {
            switchIdioma.isOn = false
        }
        
        
       
        
       
//            getdata()
        
        if commingback {
            
            myArray = [[String:String]]()
            myDict = [String:String]()
            
            predicate = NSPredicate()
            count = 0
            checkedPedido = Int32()
            sumatotal = 0.00
            sumatotalRMB = 0.00
            set = 1
            tranSecPed = String()
            total = String()
            vof = Bool()    // es precio en dolares true o false
            temrem = Double()
            delcon = Bool()
            facto = String()
            llevaEmpMad = String()
            empSeparado = String()
            Price = String()
            notaconfirmacion = String()
            colore = String()
            moneda = String()
            secpedido2 = String()
            nomPed = String()
            recuperarPed = String()
            cdbSec = Int64()
            tienecdb = Bool()
            transferPedido = String()
            regreso = Bool()
            idioma = Bool()
            calle = String()
            
            commingback = false
            tt = String()
            nombreArchivo = String()
            
            sumCbm = Double()
            refFound = false
            
            transferHistoricoPedido = Bool()
            
            if regreso == true {
                secPedido = transferPedido
                tranSecPed = secPedido  // trae el numero de pedido desde lista de pedido
                secpedido2 = secPedido
            } else {
                tranSecPed = secPedido  // trae el numero de pedido desde lista de pedido
                secpedido2 = secPedido
            }
            
            //        tranSecPed = secPedido  // trae el numero de pedido desde lista de pedido
            //        secpedido2 = secPedido
            if recuperarPed != "" {
                recuperarPed = secPedido
            } else {
                
            }
            
            
            
            
            
            
            getdata()
            tableview.reloadData()
             print("LOADING...........")
        }


    }
    override func viewDidLoad() {
        super.viewDidLoad()
       //////
        
//       emptyhistory()
        
        
        
        
        
        /////
        if regreso == true {
            secPedido = transferPedido
            tranSecPed = secPedido  // trae el numero de pedido desde lista de pedido
            secpedido2 = secPedido
        } else {
            tranSecPed = secPedido  // trae el numero de pedido desde lista de pedido
            secpedido2 = secPedido
        }
        
        //        tranSecPed = secPedido  // trae el numero de pedido desde lista de pedido
        //        secpedido2 = secPedido
        if recuperarPed != "" {
            recuperarPed = secPedido
        } else {
            
        }
        getdata()
        tableview.reloadData()
        
        print("PEDIDO ES \(tranSecPed) ")
       
        
    }
    
    
    func emptyhistory() {
        do {
            let ctx = DatabaseController.getContext()
            let searchresult = try ctx.fetch(fetchRequestHis)
            
//            var myarrayofhistory = arrayhist
            
            
            print(" cantidad de entradas en historico Database \(searchresult.count)")
            for resu in searchresult as [Pedidohistorico] {
                ctx.delete(resu)
            }
              DatabaseController.saveContext()
            
        } catch {
            print("ERROR")
        }
        
    }
    
    func getdata() {
        commingback =  false
//        myDict = [String:String]()
//        myArray = [[String:String]]()
        arrayhist = [[:]]
        dicHist = [:]
        
        
        do {
            let searchResultsDetalle = try DatabaseController.getContext().fetch(fetchRequestDet)
            
            //  print("Result of VIAJES: \(searchResultsViaje.count
            
            for resultv in searchResultsDetalle as [Detalle] { //LOOP
                
                if resultv.numeroDePedido > 0 {
                    
                    if Int32(secPedido) == resultv.numeroDePedido {
                        
                        
                        pedidonumLabel.text = "Pedido No.: \(secPedido)"
                        
                        
                        // buscar cuantas referecnias perteneciente a este PEDIDO
                        
                        //                       Add Predicate Working PErfect
                        
/////////////// DOUBLE PREDICATE INSERT TIME STAMP
                        
                        let predicate = NSPredicate(format: "ANY det.numeroDePedido == %@", "\(resultv.numeroDePedido)")
                        
                        fetchRequestRef.predicate = predicate
                        
                        
                         //     request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
                        // let predicate2 = NSPredicate(format: "%K = %@", "list.name", "Home")
//                        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
                        
                        
                        /////////////////
                        do {
                            let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
                            print("Cantidad de Referencia en \(resultv.numeroDePedido) es: \(searchResultRef.count)" )
                            
                            for result in searchResultRef as [Referencia] {
                                
                                count = searchResultRef.count
                                
                                
                                print("PEDIDO DEL DE AHORA  \(resultv.numeroDePedido)  TIENE \(count) ")
                                
                                myDict["referencia"] = "\(result.referencia!)"
                                myDict["descripcion"] = "\(result.descripcion!)"
                                myDict["cantidadencaja"] = "\(result.cantidadEnCaja)"
                                var a = 0.0
                                var b = 0.0
                                var c = 0.0
                                
                                a = Double(result.cantidadEnCaja)
                                b = Double(result.caja)
                                
                                
                                c = a * b
                                var total = 0.0
                                var p = 0.0
                                var p1 = 0.00
                                var p2 = 0.00
                                var p3 = 0.00
                                myDict["canttotal"] = "\(c)"
//                                let cantotal = "\(c)"
                                myDict["cajas"] = "\(result.caja)"
                                sumCbm += result.cbmtotal
                                
                                if result.precioRmb <= 0 && result.precioUsd > 0 {  //USD
                                    myDict["precio"] = "\(result.precioUsd)"
                                    myDict["soloprecio"] = "\(result.precioUsd)"
                                    Price = "\(result.precioUsd)"
                                    p = Double(result.precioUsd)
                                    p1 = p
                                    vof = true
                                    total = c * p1   // USD
                                    myDict["moneda"] = "USD$ "
                                    
                                } else if result.precioRmb > 0 && result.precioUsd <= 0 {   //RMB
                                    myDict["precio"] = "\(result.precioRmb)"
                                    myDict["soloprecio"] = "\(result.precioRmb)"
                                    Price = "\(result.precioRmb)"
                                    
                                    myDict["moneda"] = "RMB$ "
                                    //                                moneda = "RMB $ "
                                    p = Double(result.precioRmb)
                                    //////////////////// OJO ACTUALIZAR A BUSCAR LA TASA DEL uLTIMO VIAJE
                                    
                                    
                                    
                                    
                                    
                                    
                                    if rmb == "" {
                                        if let lastRmb = UserDefaults.standard.object(forKey: "ultimataza") as? String {
                                            rmb = lastRmb
                                        }
                                        
                                        
                                    }
                                    
                                    p2 = p / Double(rmb)!    // introducir taza de viaje
                                    p3 = c * p
                                    total = c * p2    // RMB
                                    vof = false
                                }
                                
                                
                                myDict["total"] = "\(total)"
                                myDict["totalrmb"] = "\(p3)"
//                                var totalUsd = "\(total)"
                                sumatotal += total
                                sumatotalRMB += p3
                                /////////////////////////
                                var contresteo = 1
                                do {
                                    let searchresult = try DatabaseController.getContext().fetch(fetchRequestHis)
                                    
                                    for resu in searchresult as [Pedidohistorico] {
                                        if contresteo == 1 {
                                        print(" cantidad de enbtradas en historico BD \(searchresult.count)")
                                        contresteo = 0
                                        }
                                 // hay que crear un atribuite named line count for each item added to the order if it has an historic also in a regular order
                                        
                                        
                                        if resultv.numeroDePedido == Int32(resu.numerodepedido!) &&  myDict["referencia"]! == resu.referencia! {
                                            refFound = true
                                            myDict["canttotal"] = "\(resu.cantidadtotal!)"
                                            myDict["cajas"] = "\(resu.cajas!)"
                                            myDict["cantidadencaja"] = "\(resu.cantidadencaja!)"
                                            
                                            myDict["precio"] = "\(resu.precio!)"
                                            transferHistoricoPedido = true
                                            
                                        }
                                    }
                                } catch {
                                    print("ERROR")
                                    
                                }
                                //
                                /////////////////////////////////////////
                                
                                myArray.append(myDict)
                                
                            }
                            
                        }catch {
                            print("ERROR")
                            
                        }
                        secpedido2 = secPedido
                        transferPedido = secPedido
                        
                        
                        ////////////////
                        secPedido = ""
                        
                    }
                    
                }
                
            }
            
            
        } catch{
            print("Error: \(error)")
            
        }
        
        
        let cont = String(format: "%.2f", arguments: [sumCbm/67.00])
        let ccbm = String(format: "%.2f", arguments: [Double(sumCbm)])
        
        
        resultadoCbm.text = "CBM: \(ccbm) CONTE : \(cont)"

        
    }
    
    
    
    @IBAction func agregarbotton(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "AGREGAR ARTICULOS AL                       PEDIDO NUM: \(tranSecPed)", message: """
                                                                                     
                                                                                     Opcion: CREAR Y AGREGAR
                                                                                     Podras crear un articulo con un
                                                                                     numero de referencia estatico y
                                                                                     automaticamente sera agregado a
                                                                                     este pedido
                                                                                     
                                                                                     Opcion: AGREGAR
                                                                                     Podras agregar un articulo existente
                                                                                     del viaje actual a este pedido
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "[ CREAR Y AGREGAR ]", style: .default, handler: { (action: UIAlertAction!) in
            //            self.salvarNuevoSuplidor(self)
            print("NO, FUE SELECCIONADO")
            self.set = 4
            
            self.performSegue(withIdentifier: "pedido2Registrar", sender: nil)
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "[ AGREGAR ]", style: .default, handler: { (action: UIAlertAction!) in
            //            self.MismoSuplidorSalvar()
            print("SI, FUE SELECIONADO")
            self.set = 9
            print("\(self.tranSecPed)")
            UserDefaults.standard.set(self.tranSecPed, forKey: "customPedido")
            
            UserDefaults.standard.synchronize()

            self.performSegue(withIdentifier: "ListaPedido2Menua", sender: nil)
           
            
            
        }))
        refreshAlert.addAction(UIAlertAction(title: "[ CANCEL]", style: .cancel, handler: { (action: UIAlertAction!) in
            //            self.salvarNuevoSuplidor(self)
            print("CANCEL , FUE SELECCIONADO")
            
            return
            
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        //    } else {
        //    self.salvarNuevoSuplidor(self)
        //
        //    }
        ///////

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CostomPedidoCell
        
        var dataBase = myArray[indexPath.row]

        
        cell.label1?.text = " \(dataBase["referencia"]!)"
       
        cell.descr?.text = "\(dataBase["descripcion"]!)"
       
        cell.cantcaja?.text = "\(dataBase["cantidadencaja"]!)"
        
        cell.cajas?.text = "\(dataBase["cajas"]!)"
        
    
       let cnt = Double("\(dataBase["canttotal"]!)")
       cell.cantotal?.text = String(format: "%.0f", arguments: [cnt!])
 
            let teru1 = Double("\(dataBase["precio"]!)")
        
        if refFound == true {
            let someValue: Double = teru1!
            
//            cell.precio?.text = "\(dataBase["precio"]!)"
             cell.precio?.text = "\(dataBase["moneda"]!)     " + someValue.cleanValue
        } else {
//            print("\(teru1)")
      let someValue: Double = teru1!
            
              cell.precio?.text = "\(dataBase["moneda"]!)     " + someValue.cleanValue
        }
      
        
            vof = Bool()
 
        let cnt2 = Double("\(dataBase["total"]!)")
        cell.totalusd?.text = String(format: "%.2f", arguments: [cnt2!])
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let label = UILabel()
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        label.numberOfLines = 1
//        label.lineBreakMode = .byWordWrapping
//          label.lineBreakMode = .byTruncatingMiddle
        
        
        
        if switchIdioma.isOn {
            // 4 espacio delante de ITEM NO.
            label.text = "    ITEM NO.        DESCRIPTION     QTY IN  CTN     CTNS         QTY           PRICE       TOTAL USD "
            
        } else {
            label.text = "    PRODUCTO    DESCRIPCION    CANT X CAJA  CAJAS   CANTIDAD    PRECIO    TOTAL USD "
            
        }
        
        
        return label
    }
 
    

   
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print("THIS: \(section)")
//
//          var label = UILabel()
//        label.backgroundColor = UIColor.blue
//        label.textColor = UIColor.white
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//
//
//
//
//        if switchIdioma.isOn {
//             label.text = "ITEM NO.       DESCRIPTION      QTY IN  CTN     CTNS         QTY           PRICE       TOTAL USD "
//
//        } else {
//            label.text = "PRODUCTO  DESCRIPCION    CANT X CAJA  CAJAS   CANTIDAD    PRECIO    TOTAL USD "
//
//        }
//
//        return label.text
//    }
    
    @IBAction func swichIdiomaChange(_ sender: Any) {

        if switchIdioma.isOn {
            idioma = true
          
        } else {
            idioma = false
           
        }
        tableview.reloadSectionIndexTitles()
        
        tableview.reloadData()
      
        

    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let decim1 = Double(sumatotal)
        let decim = Double(sumatotalRMB)
        
        labeltotal.text = "TOTAL RMB $ \(String(format: "%.2f", decim)) USD $ \(String(format: "%.2f", decim1))"
        tt = String(format: "%.2f", decim)
        tt = String(format: "%.2f", decim1)
        
      return ""
            
    }
    
    @IBAction func enviarPedidoButton(_ sender: Any) {
//        var facBool = false    //no esta en uso por nada
        
        if nombrePedidoTf.text == "" {
            print("deve ingresar nombre del pedido")
            return
        }
       
        var numeroFoto = String()
        
        tranSecPed = secPedido
     
        //////////////////
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
            
            print("number of results: \(searchResults.count)")
            
            
            if searchResults.count > 0 {
                
                for result in searchResults as [Configuracion]{
                    
                    
                    if result.tipo == "principal" {
                        
                        cdbSec = result.cdbSec
                        
                        
                        
                    }
                }
                
            }
        } catch {
            print ("Error")
            
        }
       
        ///////////////////
         myDict = [String:String]()
         myArray = [[String:String]]()
        if let ttgg = nombrePedidoTf.text {
            nomPed = ttgg //nombrePedidoTf.text!
        } else {
            nomPed = ":::"
        }
   
        
        do {
            let searchResultsDetalle = try DatabaseController.getContext().fetch(fetchRequestDet)
            
          
            let folder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            for resultv in searchResultsDetalle as [Detalle] { //LOOP
                
                if resultv.numeroDePedido > 0 {
          
                    if Int32(secpedido2) == resultv.numeroDePedido {
                     
                        let fileName = nombrePedidoTf.text! + "_Compra.csv"
                        nombreArchivo = fileName
                        
                        let subfolder = "Pedidos Enviados"
                       
                        guard var path = NSURL(fileURLWithPath: folder).appendingPathComponent(subfolder) else {
                            print("Unable to create URL")
                            return
                        }
                        print("\(path)")
                        
                        try! FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: [:])
                        path.appendPathComponent(fileName)
                        
                        //let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
                        var csvText = ""
                        print("CSV Path", path)
                        do {
                            let searchResu = try DatabaseController.getContext().fetch(fetchRequestCon)
                            
                            for result1 in searchResu as [Configuracion] {
                                if result1.tipo == "principal" {
                                    var mrk = String()
                                    
                                      if switchIdioma.isOn {
                                        if let tempmark = result1.mark {
                                            mrk = tempmark
                                          
                                        }
                                        
                                    csvText = "\n\("COMPANY: "),\(result1.nombre!),,\("ORDER NUMBER: "),\(secpedido2)\n,\(result1.direccion!)\n,TEL:\(result1.telefono!) EXT: \(result1.ext!) FAX: \(result1.fax!)\n,\(result1.pais!)\n,RNC: \(result1.rnc!)     SHIP. MARK: \(mrk)\n\n"
                                      } else {
                                        if let tempmark = result1.mark {
                                            mrk = tempmark
                                        }
                                        
                                       csvText = "\n\("COMPAÑIA: "),\(result1.nombre!),,\("PEDIDO NUMERO: "),\(secpedido2)\n,\(result1.direccion!)\n,TEL:\(result1.telefono!) EXT: \(result1.ext!) FAX: \(result1.fax!)\n,\(result1.pais!)\n,RNC: \(result1.rnc!)    SHIP. MARK: \(mrk)\n\n"
                                        
                                    }
                      
                                    
                                }
                                
                                
                                
                            }
                            
                            
                        }
                  
                        if switchIdioma.isOn {
                             csvText += "\n\("       "),\n\("        ")\nFactory,Picture No.,Item No.,Description,Qty in Box,Boxes,Total Quantity,Price,Total Usd,Packed With Sidewood,Seperated Packing,Colors,Observation,BarCode EAN-13\n"
                            
                            
                        } else {
                            csvText += "\n\("       "),\n\("        ")\nFactoria,Foto Numero,Referencia,Descripcion,Cantidad EN Cajas,Cajas,Cantidad Total,Precio,Total USD,Empaque de MADERA,Empaque Separado,Colores,Observacion,Codigo de Barra\n"
                        }
                   
                        // buscar cuantas referecnias perteneciente a este PEDIDO
                        
                        //                       Add Predicate Working PErfect
                        let predicate = NSPredicate(format: "ANY det.numeroDePedido == %@", "\(resultv.numeroDePedido)")
                        fetchRequestRef.predicate = predicate
                        
                        
                        
                        /////////////////
                        do {
                            let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
                            print("Cantidad de Referencia en \(resultv.numeroDePedido) es: \(searchResultRef.count)" )
                            
                            for result in searchResultRef as [Referencia] {
                                
                                count = searchResultRef.count
                                
                          
                                
//                                print("PEDIDO DEL DE AHORA  \(resultv.numeroDePedido)  TIENE \(count) ")
                                
                                myDict["referencia"] = "\(result.referencia!)"
                                myDict["descripcion"] = "\(result.descripcion!)"
                                myDict["cantidadencaja"] = "\(result.cantidadEnCaja)"
//                                print("\(result.codigoDeBarra)")
                            
                                let temcdb = "\(result.codigoDeBarra)"
                                if result.codigoDeBarra == 0 {
//                                if temcdb == "0" {
                                    print("NO TA ENTRANDO AKI :\(temcdb)")
                                
                                result.codigoDeBarra = cdbSec
                                 DatabaseController.saveContext()
                                    tienecdb = false
                                } else {
                                    
                                    tienecdb = true
                                }
                                
                                
                                var a = 0.0
                                var b = 0.0
                                var c = 0.0
                                a = Double(result.cantidadEnCaja)
                                b = Double(result.caja)
                                c = a * b
                                var total = 0.0
                                var p = 0.0
                                var p1 = 0.00
                                var p2 = 0.00
                                var p3 = 0.00
                                myDict["canttotal"] = "\(c)"
                                let cantotal = "\(c)"
                                myDict["cajas"] = "\(result.caja)"
                                
                                if result.precioRmb <= 0 && result.precioUsd > 0 {  //USD
                                    myDict["precio"] = "\(result.precioUsd)"
                                    Price = "\(result.precioUsd)"
                                    p = Double(result.precioUsd)
                                    p1 = p
                                    vof = true
                                    total = c * p1   // USD
                                    myDict["moneda"] = "USD $ "
                                    moneda = "USD $ "
                                } else if result.precioRmb > 0 && result.precioUsd <= 0 {   //RMB
                                    myDict["precio"] = "\(result.precioRmb)"
                                    Price = "\(result.precioRmb)"
                                    myDict["moneda"] = "RMB $ "
                                    moneda = "RMB $ "
                                    p = Double(result.precioRmb)
                                    //////////////////// OJO ACTUALIZAR A BUSCAR LA TASA DEL uLTIMO VIAJE RMB /////////////////////////////////
                                    let tempexchange = Double(rmb)
                                    p2 = p / tempexchange!    // introducir taza de viaje
                                    
                                    p3 = c * p  /////  RMB TOTAL PER LINE
                                    total = c * p2    // RMB
                                    vof = false
                                }
                                
                                calle = "\(result.calle!)"
                                myDict["total"] = "\(total)"
                                myDict["totalrmb"] = "\(p3)"
                                let totalUsd = "\(total)"
                                sumatotal += total
                                sumatotalRMB += p3
                                
                                let refer = "\(result.referencia!)"
                                let descrip = "\(result.descripcion!)"
                                let canEnCaja = "\(result.cantidadEnCaja)"
                                let Cajas = "\(result.caja)"
                                let cbar = "\(result.codigoDeBarra)"
                                
                                if result.empaqueConMadera != nil {
                                    llevaEmpMad = "\(result.empaqueConMadera!)"
                                } else {
                                    llevaEmpMad = ""
                                }
                                
                                if result.formaDeEmpaque != nil {
                                    empSeparado = "\(result.formaDeEmpaque!)"
                                } else {
                                    empSeparado = ""
                                }
                                
                                
                                if result.colores != nil {
                                    let color = "\(result.colores!)"
                                    let arr1 = color.components(separatedBy: ",")
                                    var cloStr = String()
                                    for i in arr1 {
                                        cloStr.append(i + " ")
                                        
                                    }
                                    
                                    
                                    colore = "\(cloStr)"
                                    
                                    print("\(colore)")
                                    
                                    
                                    
                                    
                                } else {
                                    colore = ""
                                }
                                
                                if result.observacion != nil {
                                    notaconfirmacion = "\(result.observacion!)"
                                } else {
                                    notaconfirmacion = ""
                                }
                                
                                if result.fabrica != true {
                                facto = "\(result.suplidor!)"
                                if calle != "" {
                                    facto = facto + " C/" + calle
                                }
                                }
                                
                                if let nuFo = result.nombreDeFoto1 {
                                    numeroFoto = nuFo        //"\(result.nombreDeFoto1!)"
                                } else {
                                    numeroFoto = "N/A"
                                }
                                
                                let getdec = Double("\(totalUsd)")
                                let getdec2 = String(format: "%.2f", arguments: [getdec!])
                                //                                String(format: "%.0f", arguments: [totalUsd])
                                
                                let getpre1 = Double("\(Price)")
                                let getpre2 = String(getpre1!)
//                                var getpre2 = String(format: "%.3f", arguments: [getpre1!])
                                let getpre3 = moneda + getpre2
                                
                                let getcan1 = Double("\(cantotal)")
                                let getcan2 = String(format: "%.0f", arguments: [getcan1!])
                                
                                let newLine = "\(facto),\(numeroFoto),\(refer),\(descrip),\(canEnCaja),\(Cajas),\(getcan2),\(getpre3),\(getdec2),\(llevaEmpMad),\(empSeparado),\(colore),\(notaconfirmacion),\(cbar)\n"
//                                var arrayhist = [String]()
                                dicHist["referencia"] = refer
                                dicHist["cajas"] = Cajas
                                dicHist["Cantidadencaja"] = canEnCaja
                                dicHist["fecha"] = formatterDateTime()
                                dicHist["numerodepedido"] = secpedido2
                                dicHist["moneda"] = moneda
                                dicHist["cantidadtotal"] = getcan2
                                dicHist["precio"] = getpre3
                                dicHist["soloprecio"] = getpre2
                                
                                
                                
                                arrayhist.append(dicHist)
                      
                                if tienecdb == false {
                                 cdbSec += 1
                                }
                                csvText.append(newLine)
                                
                                tienecdb = Bool()
                         
                            }
                            //                            let newLine = "\n\(""),\(""),\(""),\(""),\(""),\(""),\(""),\("")\n"
                            //                            csvText.append(newLine)
//                            let getdeca = Double("\(sumatotal)")
//                            var getdecb = String(format: "%.2f", arguments: [getdeca!])
                            
                            let newLine = "\n\(""),\(""),\(""),\(""),\(""),\(""),\(""),\("")\n\n\(""),\(""),\(""),\(""),\(""),\(""),\("TOTAL USD$"),\(tt)\n"
                            csvText.append(newLine)
                 
                            
                            
                            var notfound = false
//                            var addingtoPed = false
                            var arrayRefFound = [String]()
                            var addref = false
                            //// save barcode to coredata
                            
                            do {
                                let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
                                
                                print("number of results: \(searchResults.count)")
                                
                                
                                if searchResults.count > 0 {
                                    
                                    for result in searchResults as [Configuracion]{
                                        
                                        
                                        if result.tipo == "principal" {
                                            
                                            result.cdbSec = cdbSec
                                            if Int32(secpedido2) == result.secuenciaPedido {
                                                
                                                result.secuenciaPedido += 1
                                                
                                            }
                                            
                                            
                                            DatabaseController.saveContext()
                                            
                                            
                                        }
                                    }
                                    
                                }
                            } catch {
                                print ("Error")
                                
                            }
                            /////////////
                            
                            
                            
                            
                            
                            
                            /////////////
                            var AS = 0
                            do {
                                let searchresult = try DatabaseController.getContext().fetch(fetchRequestHis)
                                
//                                var myarrayofhistory = arrayhist
                                
                                for i in 1..<arrayhist.count {
                                    print("array de datos en pedido \(i)")
                                    
                                    var mr = arrayhist[i]
                                
                                    
                                for resu in searchresult as [Pedidohistorico] {
                                    print(" cantidad de entradas en historico Database \(searchresult.count)")
                                   
                                  
                                    
                                    if secpedido2 == resu.numerodepedido && mr["referencia"] == resu.referencia {
                                        notfound = true

                                        ////////  TO DELETE ENTITY IF FOUND
//


                                        print("ENCONTRO")
                                        print("cantidad de veces: \(AS)")


                                        resu.referencia = mr["referencia"]
                                        resu.cajas = mr["cajas"]
                                         resu.cantidadencaja = mr["Cantidadencaja"]
                                         resu.fecha = mr["fecha"]
                                         resu.numerodepedido = mr["numerodepedido"]
                                         resu.cantidadtotal = mr["cantidadtotal"]
                                         resu.precio = mr["soloprecio"]
                                        resu.moneda = mr["moneda"]

                                        DatabaseController.saveContext()
                                        arrayRefFound.append(mr["referencia"]!)


 AS += 1
                                    }
                                    
                                } // for loop
                                    
                            } // end for i
                                
                            } catch {
                                print("ERROR")
                            }
//                           arrayRefnotFound = Array(Set(arrayRefnotFound))
                            print(arrayRefFound)
                            
                            
                            
                            if !arrayRefFound.isEmpty {
                                addref = true
                                
                            }
                            
                    
                            
                            
                          /////////////////////
                            if addref == true && notfound != false {
                                
                            
                            
                            for i in 0..<arrayRefFound.count {
                              print(arrayRefFound[i])

                                let index = arrayhist.index(where: { dictionary in
                                    guard let value = dictionary["referencia"] // as? String
                                        else { return false }
                                    return value == arrayRefFound[i]
                                })

                                if let index = index {
                                    arrayhist.remove(at: index)
                                }
                            
                                print(arrayhist)
                                
                                
                                
                            }
                            print("TOTAL SON:", arrayhist.count)
                            
                            if arrayRefFound.count >= 0 {
                                
                                
                            }
                            
                                

                            for i in 1..<arrayhist.count {
                                print("array de datos en pedido \(i)")
                                
                                print("datos en:" , arrayhist[0])

                                var mr = arrayhist[i]

                                if mr["referencia"] != ""
                                {
                                    let HistoriaDePedido:String = String(describing: Pedidohistorico.self)

                                let ref:Pedidohistorico = NSEntityDescription.insertNewObject(forEntityName: HistoriaDePedido, into: DatabaseController.getContext()) as! Pedidohistorico



                            ref.referencia = mr["referencia"]
                            ref.cajas = mr["cajas"]
                            ref.cantidadencaja = mr["Cantidadencaja"]
                            ref.fecha = mr["fecha"]
                            ref.numerodepedido = mr["numerodepedido"]
                            ref.cantidadtotal = mr["cantidadtotal"]
                            ref.precio = mr["soloprecio"]
                            ref.moneda = mr["moneda"]

                            DatabaseController.saveContext()

                                }
                            }

                                
                                
//                            }

                            
                           //////////////////////
                            
                            
                            
                            
                            
                            } // addreff if end
                            
                            
                            
                            
                            
                            
                            
                            
                            if notfound == false {
//                                var myarrayofhistory = arrayhist
 // var myarrayofhistory = arrayhist
                                for i in 1..<arrayhist.count {
                                    print("array de datos en pedido \(i)")

                                    var mr = arrayhist[i]

                            print("SALVO NUEVA ENTRADA")

                            //
                            let HistoriaDePedido:String = String(describing: Pedidohistorico.self)

                            let ref:Pedidohistorico = NSEntityDescription.insertNewObject(forEntityName: HistoriaDePedido, into: DatabaseController.getContext()) as! Pedidohistorico



                            ref.referencia = mr["referencia"]
                            ref.cajas = mr["cajas"]
                            ref.cantidadencaja = mr["Cantidadencaja"]
                            ref.fecha = mr["fecha"]
                            ref.numerodepedido = mr["numerodepedido"]
                            ref.cantidadtotal = mr["cantidadtotal"]
                            ref.precio = mr["soloprecio"]
                            ref.moneda = mr["moneda"]

                            DatabaseController.saveContext()



                            }


                            }

                           
                            
                            
                            do {
                                
                                let date1 = formatterDateTime()
                                
                                try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
                                //                print("File CREATED")
                                print("GOOD UNTIL HERE")
                                
                                if MFMailComposeViewController.canSendMail() {
                                    print("MAIL WORKING")
                                    
                                    let mail = MFMailComposeViewController()
                                    mail.mailComposeDelegate = self
                                    mail.setToRecipients(["cajunsniper@hotmail.com"]) // CORREO A SER ENVIADO
                                    mail.setSubject("\(nombreArchivo) \(date1)") // SUBJECT PEDIDO
                                    mail.setMessageBody("<p>Please send all information to P02G@hotmail.com Email Thank you</p>", isHTML: true)
                                    
                                    present(mail, animated: true)
                                    mail.addAttachmentData(NSData(contentsOf: path)! as Data, mimeType: "text/csv", fileName: nombreArchivo)
//                                     mail.addAttachmentData(NSData(contentsOf: path)! as Data, mimeType: "text/csv", fileName: "compra.csv")
                                } else {
                                    // show failure alert
                                }
                            } catch {
                                print("Failed to create file")
                                print("\(error)")
                            }
                       
                            
                        }catch {
                            print("ERROR")
                            
                        }
                        ////////////////
                        secpedido2 = ""
                        
                    }
                    
                }
                
            }
            
            
        } catch{
            print("Error: \(error)")
            
        }
        
      

        
//        do {
//            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
//            //                print("File CREATED")
//
//            //            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
//            //            vc.excludedActivityTypes = [
//            //                UIActivityType.assignToContact,
//            //                UIActivityType.saveToCameraRoll,
//            //                UIActivityType.postToFlickr,
//            //                UIActivityType.postToVimeo,
//            //                UIActivityType.postToTencentWeibo,
//            //                UIActivityType.postToTwitter,
//            //                UIActivityType.postToFacebook,
//            //                UIActivityType.openInIBooks
//            //            ]
//            //            present(vc, animated: true, completion: nil)
//            //
//            //            if MFMailComposeViewController.canSendMail() {
//            //
//            //                emailController.mailComposeDelegate = self
//            //                emailController.setToRecipients([]) //I usually leave this blank unless it's a "message the developer" type thing
//            //                emailController.setSubject("subject")
//            //                emailController.setMessageBody("cuerpo", isHTML: false)
//            //
//            //                present(emailController, animated: true, completion: nil)
//            //
//            //            }
        
        
       
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        tranSecPed = recuperarPed
        secpedido2 = recuperarPed
        
        controller.dismiss(animated: true)
//       self.performSegue(withIdentifier: "listaPedido2Pedido", sender: nil)
          regreso = true
        tableview.reloadData()
        
            viewDidLoad()
        
    }
    
    
    
    @IBAction func atrasListaPedido(_ sender: Any) {
        if let presenter = self.presentingViewController as? ListaDePedidos {
            presenter.set = 1
            presenter.commingback = true
            
        }
        
        dismiss(animated: true, completion: nil)
        
//        performSegue(withIdentifier: "pedido2ListaPedido", sender: nil)
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        set = 3
        let arrayPedido = myArray[indexPath.row]
        
        
        let comparePedido = arrayPedido["referencia"]!
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "pedido2Registrar", sender: comparePedido)
        
//    present(_ viewControllerToPresent: Menua,
        
//        if let presenter = self.presentingViewController as? DetallePedido {
//            presenter.secPedido = comparePedido
//            
//        }

                   
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if set == 3 {
            let guest = segue.destination as! RegistrarReferencia
            guest.secReferencia = sender as! String
            guest.existe = true
            guest.exitePedido = tranSecPed
            guest.fromPedido = true
            guest.fromMenuaCustome = false
            // guest.localSup = controlResult
           
            if transferHistoricoPedido == true {
                 guest.havehistorico = true
            }
           
            
            
        }
        if set == 4 {
          let guest = segue.destination as! RegistrarReferencia
            guest.fromDetPedCrear = true
//
//             guest.exitePedido = tranSecPed
            guest.secPedido = tranSecPed
            guest.fromPedido = true
            guest.existe = false
            guest.noSequence = true
          
            
        }
        
        
    }    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "BORRAR DEL PEDIDO"
    }
    
    // delete row with a swip
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            
            let arrayReferencia = myArray[indexPath.row]
            
            let valorRestar = arrayReferencia["total"]
            
            let comparePedido = arrayReferencia["referencia"]!
            
            myArray.remove(at: indexPath.row)
            
            tableview.deleteRows(at: [indexPath], with: .fade)
            delcon = true
          
            print("REFERENCIA BORRADA ES : \(comparePedido)")
      ////////////////////////////////////
            do {
                let searchResults4 = try DatabaseController.getContext().fetch(fetchRequestRef)
                
                 for resu in searchResults4 as [Referencia] {
                    let tempRef = "\(comparePedido)"
                   
                    
                        if resu.referencia == tempRef {
                   
//                             let nomDetalle: String = String(describing: Detalle.self)
                            let det1 = try DatabaseController.getContext().fetch(fetchRequestDet)
                        
                            for det in det1 {
                        
                                if det.numeroDePedido == Int32("\(tranSecPed)") {
                                       det.removeFromRef(resu)
                                       DatabaseController.saveContext()
                                   
                                    let valorR = Double("\(valorRestar ?? "0.00")")
                                    if delcon == true {
                                    sumatotal = sumatotal - valorR!
                                        delcon = Bool()
                                    }
                                    
                               
                                    
                                    
                            }
                        }
                  }
                    
              }
           
            } catch {
                
            }

 
        } // End IF Delete
        

    }
///// last func called
 
   
    
    
}  // end class

//extension Float {
//    var cleanValue: String {
//        return self % 1 == 0 ? String(format: "%.0f", self) : String(self)
//    }
//}


extension Double
{
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}







