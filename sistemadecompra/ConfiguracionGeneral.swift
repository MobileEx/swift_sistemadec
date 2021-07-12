//
//  ConfiguracionGeneral.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/12/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData

class ConfiguracionGeneral: UIViewController , UITextFieldDelegate {

    var userd = UserDefaults.standard
    var salvado: Bool?
    var len = 100
    var valtext = Int64()
    var secnumero = Int64()
    var desde = Int64()
    var hasta = Int64()
    var mydic = [Int:Int]()
    var aray1 = [Any]()
    var aray2 = [Any]()
    var concuerdan = Bool()
    
    
    //---------REFERENCIA-------------------
    @IBOutlet weak var refLet: UITextField!
    @IBOutlet weak var refNum: UITextField!
    
    //-----------SECUENCIA------------------
    @IBOutlet weak var refSecLet: UILabel!
    @IBOutlet weak var refSecNum: UILabel!
    
    //---------REFERENCIA FACTORIA----------
    @IBOutlet weak var reffLet: UITextField!
    @IBOutlet weak var reffSup: UITextField!
    @IBOutlet weak var reffNum: UITextField!
    
    //----------SECUENCIA-------------------
    @IBOutlet weak var reffSecLet: UILabel!
    @IBOutlet weak var refSecSup: UILabel!
    @IBOutlet weak var reffSecNum: UILabel!
    
    //------------CODIDO DE BARA------------
    @IBOutlet weak var cdbPri: UITextField!
    @IBOutlet weak var cdbFin: UITextField!
    
    //-------------SECUENCIA----------------
    @IBOutlet weak var cdbSec: UILabel!
    
    //-------------CAMBIAR CLAVE------------
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var conEmail: UITextField!
    @IBOutlet weak var claveActual: UITextField!
    @IBOutlet weak var nuevaClave: UITextField!
    @IBOutlet weak var confirmarClave: UITextField!
    
    //-------------SACAR CODIGOS DE BARRA------------
    
    @IBOutlet weak var resultadoCodigo: UITextView!
    
    @IBOutlet weak var EntradaCantidad: UITextField!
    
    @IBOutlet weak var confirmar: UIButton!
    
    
    //------------------------------------------------
    
    @IBOutlet weak var principioPedido: UITextField!
    
    
    @IBOutlet weak var secped: UILabel!
    
    
    @IBOutlet weak var clavelabel: UILabel!
    
    @IBOutlet weak var labelConfirmarClave: UILabel!
    
    @IBOutlet weak var letrerocambiarclave: UILabel!
    
    @IBOutlet weak var correoLabel: UILabel!
  
    @IBOutlet weak var cambiarClaveLabel: UILabel!
    
    //----------- Consignee--------------
    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var direccion: UITextField!
    
    @IBOutlet weak var telefono: UITextField!
    
    @IBOutlet weak var extencion: UITextField!
    
    @IBOutlet weak var fax: UITextField!
    
    @IBOutlet weak var pais: UITextField!
    
    @IBOutlet weak var rnc: UITextField!
    
    @IBOutlet weak var mark: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let vc = UIViewController()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
//
        let userD1 = UserDefaults.standard
        userD1.set(0, forKey: "indexpath") // clear save row avoid crash
        userD1.synchronize()
        
         confirmar.isHidden = true
        //----------REFERECNIA--------------
        self.refLet.delegate = self
        self.refNum.delegate = self
        
        //---------REFERENCIA FACTORIA----------
//        self.reffLet.delegate = self
//        self.reffSup.delegate = self
//        self.reffNum.delegate = self
        
        //------------CODIDO DE BARA------------
        self.cdbPri.delegate = self
        self.cdbFin.delegate = self
        
        //-------------CAMBIAR CLAVE------------
        self.email.delegate = self
        self.claveActual.delegate = self
        self.nuevaClave.delegate = self
        self.confirmarClave.delegate = self

     
        
    }  // END VIEWDIDLOAD -------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        
        //--------------------SAVE DATA TO ENTETY CONFIGURACION------------------
        //        let NumeroDeReferencia:String = String(describing: Referencia.self)
        //
        //        let ref:Referencia = NSEntityDescription.insertNewObject(forEntityName: NumeroDeReferencia, into: DatabaseController.getContext()) as! Referencia
        //
        
        
        
        //-----------------Create Fetchrequest On Entety--------------------------
        // I HAVE CREATED A PUBLIC VARIABLE IN APPDELEGATE WITH THIS FUNCTION
        //        let fetchRequest:NSFetchRequest<Configuracion> = Configuracion.fetchRequest()
        
        
        //-----------------------Sort Data ASCENDING-----------------------
        //        let sortDescriptor = NSSortDescriptor(key: "descripcion", ascending: true)
        //        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
            
            print("number of results: \(searchResults.count)")
            
            
            if searchResults.count > 0 {
                
                for result in searchResults as [Configuracion]{
                    
                    
                    if result.tipo == "principal" {
                        
                        
                        
                        refLet.text = "\(result.refLet!)"
                        
                        refNum.text = "\(result.refNum)"
                        refSecLet.text = "\(result.refLet!)"  //secuencia
                        refSecNum.text = "\(result.refSecNum)"    //secuencia
                        
//                        reffLet.text = "\(result.reffLet!)"
//                        reffNum.text = "\(result.reffNum)"
//                        reffSecLet.text = "\(result.reffLet!)"   //secuencia
//                        reffSecNum.text = "\(result.reffSecNum)"   //secuencia
                        
                        cdbPri.text = "\(result.cdbPri)"
                        cdbSec.text = "\(result.cdbSec)"    //secuencia
                        cdbFin.text = "\(result.cdbFin)"
                
                        if result.nombre != "" {
                        nombre.text = result.nombre
                        } else {
                            nombre.text = ""
                        }
                        
                        if result.nombre != "" {
                           direccion.text = result.direccion
                        } else {
                            direccion.text = ""
                        }
                        
                        if result.nombre != "" {
                             telefono.text = result.telefono
                        } else {
                            telefono.text = ""
                        }
                       
                        if result.nombre != "" {
                            fax.text = result.fax
                        } else {
                            fax.text = ""
                        }
                       
                        if result.nombre != "" {
                            pais.text = result.pais
                        } else {
                            pais.text = ""
                        }
                       
                        if result.nombre != "" {
                            rnc.text = result.rnc
                        } else {
                            rnc.text = ""
                        }
                        if result.mark != "" {
                            mark.text = result.mark
                        } else {
                            mark.text = ""
                        }
                        
                        
                        
                        
                        if result.nombre != "" {
                            extencion.text = result.ext
                        } else {
                            extencion.text = ""
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        principioPedido.text = "\(result.principioPedido)"
                        
                        secped.text = "\(result.secuenciaPedido)"
                        
                       claveActual.text = ""
                       
                       nuevaClave.isHidden = true
                       confirmarClave.isHidden = true
                       clavelabel.isHidden = true
                       labelConfirmarClave.isHidden = true
                        
                        letrerocambiarclave.isHidden = true
                        correoLabel.isHidden = true
                        cambiarClaveLabel.isHidden = true
                        email.isHidden = true
                        conEmail.isHidden = true

                        concuerdan = true
                        
                    }  //END IF
                } // END FOR
                
            } else {
                
                refLet.text = ""
                refNum.text = ""
                refSecLet.text = ""   //secuencia
                refSecNum.text = ""    //secuencia
                
//                reffLet.text = ""
//                reffNum.text = ""
//                reffSecLet.text = ""   //secuencia
//                reffSecNum.text = ""   //secuencia
                            nombre.text = ""
                
                            direccion.text = ""
                
                            telefono.text = ""
                
                            extencion.text = ""
                
                            fax.text = ""
                
                            pais.text = ""
                
                            rnc.text = ""
                
                
                cdbPri.text = ""
                cdbSec.text = ""    //secuencia
                cdbFin.text = ""
                
                email.text = ""
                conEmail.text = ""
                claveActual.text = ""
                nuevaClave.text = ""
                confirmarClave.text = ""
                
                
            }
            
            
            
        } catch
        {
            print("Error: \(error)")
        }
        
        
        
        
        
        
        
        
        if let sv = userd.object(forKey: "fuesalvado") as? Bool {
            salvado = sv
        }
        
        
        
        
        
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
    
    //-------------EDIT CHANGE REFERECNIAS--------------
    @IBAction func refLetDidChange(_ sender: Any) {
        refSecLet.text = refLet.text
    }
    
    
    @IBAction func pedidoChange(_ sender: Any) {
        secped.text = principioPedido.text
    }
    
    
    @IBAction func refNumDidChange(_ sender: Any) {
        refSecNum.text = refNum.text
    }
    //------------EDIT CHANGE REFERECNIA FACTORIA-----------
    
    
//    @IBAction func reffLetDidChange(_ sender: Any) {
//        reffSecLet.text = reffLet.text
//    }
//
//    @IBAction func reffNumDidChange(_ sender: Any) {
//        reffSecNum.text = reffNum.text
//    }
    
   
    @IBAction func cdbfinaldidchange(_ sender: Any) {
        if cdbFin.text != "" {
            cdbFin.text = cdbFin.text
        }
    }
    
    @IBAction func secuenciaCdbDidChange(_ sender: Any) {
        cdbSec.text = cdbPri.text
    }
    
    @IBAction func cdbdidBegin(_ sender: Any) {
         cdbFin.text = cdbFin.text
        print ("BEGIN")
        aray1 = []
        aray2 = []
        
    }
    
    @IBAction func codfinaldidfinish(_ sender: Any) {
        let a = cdbFin.text?.count
        let b = cdbPri.text?.count
        print("STAGE 0 REREWRWERWERWERWERWER SD FSF SSDF SDFSDF S")
        if a != b {
            
            let refreshAlert = UIAlertController(title: "ALERTA", message: """
                                                                                             Codigo de Barra
                                                                                     Esta Inconpleto Porfavor Completar
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
        
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
               
                print("OK, FUE SELECIONADO")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        
        
//            cdbFin.becomeFirstResponder()
            return
            
            
        }
        
        if a == b {
             print ("STAGE 2")
//            var cn = 0
            let c = cdbFin.text
            let d = cdbPri.text
            
            
            for i in c! {
            
                 aray1.append("\(i)")
            }
            
            for i in d! {
                aray2.append("\(i)")
            }
            
            
            
            
            
        } // end if a == b
        
//        print("\(aray1[0])")
//        print("\(aray2[0])")
        var x = 0
        while x < 7 {
            
        
            let e = Int("\(aray1[x])")
            let f = Int("\(aray2[x])")
     
            if e == f {
               
                concuerdan = true
            } else {
                let refreshAlert = UIAlertController(title: "ALERTA", message: """
                                                                                     Los Numeros de Codigo de Barra
                                                                                     no concuerdan Porfavor de Revisar
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                    print("OK, FUE SELECIONADO")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                 concuerdan = false
                return
               
            }
            
            
            
            
        x += 1
        }
        
        
    }
    
    
    
    
    
    @IBAction func extraerCambio(_ sender: Any) {
        // textfield cambio
         confirmar.isHidden = true
        if EntradaCantidad.text == "" {
             resultadoCodigo.text = ""
        }
        resultadoCodigo.text = ""
        
        if EntradaCantidad.text != "" {
            confirmar.isHidden = false
//            print("ITS SAFE TO UNWRAP: " + EntradaCantidad.text!)
            let te1 = EntradaCantidad.text!
            let te2 = cdbFin.text!
//            print (te1 + " " + te2)
            valtext = Int64("\(te1)")!
            secnumero = Int64("\(te2)")!
            print("val \(valtext)")
            print("sec \(secnumero)")
            
            if (secnumero - 1) >= valtext {
                desde = secnumero - valtext
               
            } else {
                 print("NO SE PUEDE HACER LA OPERACION:")
                EntradaCantidad.text = ""
                resultadoCodigo.text = ""
                confirmar.isHidden = true
                return
            }
            
            print("desde: \(desde) hasta: \(secnumero)")
            
resultadoCodigo.text = """
                               CODIGOS A EXTRAER SON:

                       DESDE: \(desde)

                       HASTA: \(secnumero)
                       """
}
        
    
        
       
        


    }
    
    
    @IBAction func endCantidadExtraer(_ sender: Any) {
        
        
    }
    
    @IBAction func CambioCodigoAceptado(_ sender: Any) {
    // button confirmar
        cdbFin.text = "\(desde - 1)"
        comensar(self)
        
    }
    
    @IBAction func cambiarClave(_ sender: Any) {
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestCon)
        
            for result in searchResults as [Configuracion]{
                if result.tipo == "principal" {
                    let cva = String(result.claveActual)
                    if claveActual.text == cva {
                        
                        
                        nuevaClave.isHidden = false
                        confirmarClave.isHidden = false
                        clavelabel.isHidden = false
                        labelConfirmarClave.isHidden = false
                        letrerocambiarclave.isHidden = true
                        correoLabel.isHidden = false
                        cambiarClaveLabel.isHidden = false
                        email.isHidden = false
                        conEmail.isHidden = false
                        email.text = result.email
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
            
        }
        catch
        {
            
        }
    
        
        
        
    
    
    }
    
    @IBAction func confirmarClaveDidEnd(_ sender: Any) {
        if confirmarClave.text != "" {
            if nuevaClave.text != confirmarClave.text {
                
                let alert = UIAlertController(title: "ADVERTENCIA!", message: "LA CLAVE NO SON IGUALES Porfavor Vuelva a Intentar" , preferredStyle: UIAlertControllerStyle.alert)
                
                //CREATING ON BUTTON
                alert.addAction(UIAlertAction(title: "Regresar", style: UIAlertActionStyle.default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                    
                    print ("Entendido")
                    self.confirmarClave.text = ""
                    
                    self.confirmarClave.becomeFirstResponder()
                }))
                
                //                            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
                //                                alert.dismiss(animated: true, completion: nil)
                //                                print("NO")
                //                            }))
                //
                self.present(alert, animated: true, completion: nil)
                
                
                
                
                
            }
            
            
        }
    }
    
    
    @IBAction func confirmarcorreo(_ sender: Any) {
        if conEmail.text != "" {
        if email.text != conEmail.text {
            
            let alert = UIAlertController(title: "ADVERTENCIA!", message: "Los Correos No son Iguales Porfavor Vuelva a Intentar" , preferredStyle: UIAlertControllerStyle.alert)
            
            //CREATING ON BUTTON
            alert.addAction(UIAlertAction(title: "Regresar", style: UIAlertActionStyle.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                
                print ("Entendido")
                self.conEmail.text = ""
                
                self.conEmail.becomeFirstResponder()
            }))
            
            //                            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            //                                alert.dismiss(animated: true, completion: nil)
            //                                print("NO")
            //                            }))
            //
            self.present(alert, animated: true, completion: nil)
            

            
            
            
        }
        
        
        }
        
        
    }
    
    
    
    
    @IBAction func comensar(_ sender: Any) {
        
        if salvado != true {
        
        
            
      
            
          
         
            
         
            
         
            
            
            
           
            
            
            
        if refLet.text != "" && refNum.text != "" && cdbPri.text != "" && cdbFin.text != "" && conEmail.text != "" && confirmarClave.text != "" && concuerdan != false && nombre.text != "" && direccion.text != "" && telefono.text != "" && pais.text != "" && pais.text != "" && rnc.text != "" && mark.text != "" {
        
//        
//        salvado = true
//        userd.set(salvado, forKey: "fuesalvado")
//        userd.synchronize()
//        
//        let nomconf: String = String(describing: Configuracion.self)
//        
//        let conf: Configuracion = NSEntityDescription.insertNewObject(forEntityName: nomconf, into: DatabaseController.getContext()) as! Configuracion
//        
//        conf.refLet = refLet.text
//        conf.refNum = Int32(refNum.text!)!
//        conf.refSecNum = Int32(refSecNum.text!)!    //secuencia
//        conf.reffLet = reffLet.text
//        conf.reffNum = Int32(reffNum.text!)!
//        conf.reffSecNum = Int32(reffSecNum.text!)!   //secuencia
//        conf.cdbPri = Int32(cdbPri.text!)!
//        conf.cdbSec = Int32(cdbSec.text!)!   //secuencia
//        conf.cdbFin = Int32(cdbFin.text!)!
//        conf.email = email.text
//        conf.claveActual = Int32(claveActual.text!)!
//        DatabaseController.saveContext()
//                        print("TIPO PRINCIPAL ENCONTRADO!!!")
//        
        
                        
          salvado = true
          userd.set(salvado, forKey: "fuesalvado")
          userd.synchronize()
                        
          let nomconf: String = String(describing: Configuracion.self)
          let conf: Configuracion = NSEntityDescription.insertNewObject(forEntityName: nomconf, into: DatabaseController.getContext()) as! Configuracion
                        
          conf.refLet = refLet.text
        
         conf.refNum = Int32(refNum.text!)!
        conf.refSecNum = Int32(refSecNum.text!)!    //secuencia
        
//        conf.reffLet = reffLet.text
//
//          conf.reffNum = Int32(reffNum.text!)!
//          conf.reffSecNum = Int32(reffSecNum.text!)!    //secuencia
            
//
            conf.nombre = nombre.text

            conf.direccion = direccion.text

            conf.telefono = telefono.text
            conf.ext = extencion.text

            conf.fax = fax.text

            conf.pais = pais.text

            conf.rnc = rnc.text
            
            conf.mark = mark.text
            
            
        
        conf.cdbPri = Int64(cdbPri.text!)!
        conf.cdbSec = Int64(cdbSec.text!)!   //secuencia
        conf.cdbFin = Int64(cdbFin.text!)!
        
        conf.email = email.text
       
          conf.claveActual = Int32(nuevaClave.text!)!
          conf.tipo = "principal"
          conf.principioPedido = Int32(principioPedido.text!)!
            conf.secuenciaPedido = Int32(secped.text!)!
            UserDefaults.standard.set(nil, forKey: "customPedido")
            
            UserDefaults.standard.synchronize()
            
            userd.set(2, forKey: "segmentmenu")
            userd.synchronize()
            
                        print("CREADO")
                 DatabaseController.saveContext()
                        
                        
        
        
    
        
               
        
        
        performSegue(withIdentifier: "Configuracion2Menu", sender: self)
                
        
    
        }
            
            
            
        
        } else if refLet.text != "" && refNum.text != "" && cdbPri.text != "" && cdbFin.text != "" && concuerdan != false && nombre.text != "" && direccion.text != "" && telefono.text != "" && pais.text != "" && pais.text != "" && rnc.text != "" && mark.text != "" {
                
                //
                //        salvado = true
                //        userd.set(salvado, forKey: "fuesalvado")
                //        userd.synchronize()
                //
                //        let nomconf: String = String(describing: Configuracion.self)
                //
                //        let conf: Configuracion = NSEntityDescription.insertNewObject(forEntityName: nomconf, into: DatabaseController.getContext()) as! Configuracion
                //
                //        conf.refLet = refLet.text
                //        conf.refNum = Int32(refNum.text!)!
                //        conf.refSecNum = Int32(refSecNum.text!)!    //secuencia
                //        conf.reffLet = reffLet.text
                //        conf.reffNum = Int32(reffNum.text!)!
                //        conf.reffSecNum = Int32(reffSecNum.text!)!   //secuencia
                //        conf.cdbPri = Int32(cdbPri.text!)!
                //        conf.cdbSec = Int32(cdbSec.text!)!   //secuencia
                //        conf.cdbFin = Int32(cdbFin.text!)!
                //        conf.email = email.text
                //        conf.claveActual = Int32(claveActual.text!)!
                //        DatabaseController.saveContext()
                //                        print("TIPO PRINCIPAL ENCONTRADO!!!")
                //
                
                
                salvado = true
                userd.set(salvado, forKey: "fuesalvado")
                userd.synchronize()
                
                let nomconf: String = String(describing: Configuracion.self)
                let conf: Configuracion = NSEntityDescription.insertNewObject(forEntityName: nomconf, into: DatabaseController.getContext()) as! Configuracion
            
                conf.refLet = refLet.text
                conf.refNum = Int32(refNum.text!)!
                conf.refSecNum = Int32(refSecNum.text!)!    //secuencia
//                conf.reffLet = reffLet.text
//                conf.reffNum = Int32(reffNum.text!)!
//                conf.reffSecNum = Int32(reffSecNum.text!)!    //secuencia
                conf.cdbPri = Int64(cdbPri.text!)!
                conf.cdbSec = Int64(cdbSec.text!)!   //secuencia
                conf.cdbFin = Int64(cdbFin.text!)!
                conf.email = email.text
               //conf.claveActual = Int32(nuevaClave.text!)!
                conf.tipo = "principal"
            
            conf.nombre = nombre.text
            
            conf.direccion = direccion.text
            
            conf.telefono = telefono.text
            
            conf.ext = extencion.text
            
            conf.fax = fax.text
            
            conf.pais = pais.text
            
            conf.rnc = rnc.text
            
            conf.mark = mark.text
            
            
            
            
            conf.principioPedido = Int32(principioPedido.text!)!
            conf.secuenciaPedido = Int32(secped.text!)!
            UserDefaults.standard.set(nil, forKey: "customPedido")
            
            UserDefaults.standard.synchronize()

                print("CREADO")
                DatabaseController.saveContext()
            
                //   aki
             dismiss(animated: true, completion: nil)
//                performSegue(withIdentifier: "Configuracion2Menu", sender: self) // a menu
            
                

            
            
            
        }
            
            
    }
    
    
    @IBAction func cancelarboton(_ sender: Any) {
        if salvado == true {
            dismiss(animated: true, completion: nil)
//            performSegue(withIdentifier: "Configuracion2Menu", sender: self)     // a menu
        } else {
            
            dismiss(animated: true, completion: nil)
//            performSegue(withIdentifier: "configuracion2Bienvenidos", sender: self)

            
        }
        
        
        
    }
    
  
//-------------IF TEXTFIELD SOULD CHANGE FUNCTION RESTRICTING CHARACTERS ----------------------
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == claveActual || textField == nuevaClave || textField == confirmarClave {
            len = 6
            let currentCharacterCount = (textField.text?.count) ?? 0
            
            
            if (range.length + range.location > currentCharacterCount){
                return false
            }

            
            
            
            
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= len
      
        } else if textField == cdbPri || textField == cdbFin {
            len = 12
            let currentCharacterCount = (textField.text?.count) ?? 0
            
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= len
        
        } else {
       
            
            
            return true            }
        
    }

    
    
    
    
    
    
    
    
    
    
}
