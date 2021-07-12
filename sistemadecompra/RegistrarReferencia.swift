//
//  RegistrarReferencia.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/21/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices
import Photos
private var kAssociationKeyNextField: UInt8 = 0

class RegistrarReferencia: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, GetsImageFromAsset {
   var secReferencia = "PG-0000"
   var localSup = String()
    var secrefnum: Int32 = 0
    var existe = false
    var userD = UserDefaults.standard
    var oldReferencia = String()
    var deleteOldRef:Bool = false
    var supinicials = String()
    var continuar = false
    var reftwoparts = String()
    var arrayViajes: [String] = []
    var fromInv = false
    var haveFoto: Bool = false
       var imagePic = UIImagePickerController()
    var fromPedido = false
    var repetir = Bool()
    // viaje variables
    var selectivo = Double()
    var aduana = Double()
    var flete = Double()
    var gn = Double()
    var itebis = Double()
    var material = Double()
    var tazaRmb = Double()
    var tazaUsd = Double()
    var reflet = String()
    var tipoMercancia = String()
    var masfle = Double()
    var prexlib = Double()
    var secPedido = String()
    var exitePedido = String()
    var didmac = Bool()
    var ultimoviaje2 = String()
    var targeta = Bool()
    var totalcolors = [String]()
     var coloresString = String()
    var cbm = String()
    var totalcbm = String()
    var fromConfirmar = Bool()
    var factoriabool = Bool()
    var nopaso = Bool()
//    var imgNamItem = String()
    var imgNamCard = String()
    var eligio = Bool()
    var arrayCbmDouble = [Double]()
    var conteoContenedor = Double()
    var fromDetPedCrear = Bool()
    var customPedido = Bool()
    var tempname = String()
    var agregarAlpedidoDirecto = Bool()
    var transferPedido = String()
    
     var tiene = Bool()
    var fromMenuaCustome = Bool()
    var noSequence = Bool()

    var havehistorico = Bool()
    var images = [String: PHAsset]()
    
    var tipo:[String] = ["CRISTALERIA","JUGUETES","COSINA","PELUCHE","FLORES","ESCOLARES","GENERAL","NAVIDAD","SANVALENTIN","CUMPLEANO"]
    var nomfototar = String()
    var nomfoto1 : String?
    var nomfoto2 = String()
    var nomfoto3 = String()
    
    
    
    @IBOutlet weak var nuevosupbotton: UIButton!
    
   // @IBOutlet weak var cantidadTotal: UILabel!

    weak var delegate: UpdateImage?
    
    @IBOutlet weak var suplidorLabel: UITextField!
    @IBOutlet weak var nombreDeViaje: UILabel!
    @IBOutlet weak var LocalSuplidorLabel: UILabel!
    @IBOutlet weak var SecRefLabel: UILabel!
    @IBOutlet weak var cantidadEnCaja: UITextField!
    @IBOutlet weak var descripcion: UITextField!
    @IBOutlet weak var cajas: UITextField!
    @IBOutlet weak var precio: UITextField!
    @IBOutlet weak var categoriaField: UITextField!
//    @IBOutlet weak var confirmarField: UITextField!
    
    @IBOutlet weak var confirmarField: UITextView!
    
    @IBOutlet weak var nuevoSupSave: UIButton!
    @IBOutlet weak var mismoSupSave: UIButton!
    @IBOutlet weak var pickerViaje: UIPickerView!
    @IBOutlet weak var precioUSD: UITextField!
    @IBOutlet weak var codigoDeBarrra: UILabel!
    @IBOutlet weak var libras: UITextField!
    @IBOutlet weak var ppv: UILabel!
    @IBOutlet weak var cantidadTotal: UILabel!
    @IBOutlet weak var totalUsd: UILabel!
    @IBOutlet weak var totalRmb: UILabel!
    
    @IBOutlet weak var totalcontenedor: UILabel!
    @IBOutlet weak var cdbLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var totalCbmLabel: UILabel!
    @IBOutlet weak var cbmField: UITextField!
    @IBOutlet weak var imagenDeTargeta: UIImageView!
    @IBOutlet weak var calle: UITextField!
    
    @IBOutlet weak var cdbTextField: UITextField!
    // Switchs
    
    @IBOutlet weak var SwitchSelectivo: UISwitch!
    @IBOutlet weak var switchEmpaque: UISwitch!
    @IBOutlet weak var switchEmpaqueSeparado: UISwitch!
    @IBOutlet weak var switchCategoria: UISwitch!
    @IBOutlet weak var switchConfirmar: UISwitch!
    
    @IBOutlet weak var swichPrecios: UISwitch!
    // if suplier starts with a numeber and leter or leter and a number then
    
    @IBOutlet weak var tipoDeMercanciaSegment: UISegmentedControl!
    
    @IBOutlet var ColoresOutlet: [UIButton]!
    
    @IBOutlet weak var labelFoto: UILabel!
    /// individual colors
    
    @IBOutlet weak var black: UIButton!
    @IBOutlet weak var blanco: UIButton!
    
    @IBOutlet weak var crema: UIButton!
    @IBOutlet weak var marron: UIButton!
    @IBOutlet weak var azul: UIButton!
    @IBOutlet weak var gris: UIButton!
    
    @IBOutlet weak var mamey: UIButton!
    
    @IBOutlet weak var ordenar: UIButton!
  
    @IBOutlet weak var amarillo: UIButton!
    
    @IBOutlet weak var rojo: UIButton!
    
    @IBOutlet weak var rosado: UIButton!
    
    @IBOutlet weak var verde: UIButton!
    
    @IBOutlet weak var azulcielo: UIButton!
    
    @IBOutlet weak var morado: UIButton!
    
    @IBOutlet weak var ImageViewTar: UIImageView!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var EntradaReferencia: UITextField!
    
    
    @IBOutlet weak var cmTextfield: UITextField!
    
    
    @IBOutlet weak var cmTitulo: UILabel!
    
    
    
    var fotoReferencia: String?
    var fotoReferencia2: String?
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if cbmField == textField || libras == textField || precio == textField || cajas == textField || cantidadEnCaja == textField || categoriaField == textField {
        
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
        } else {    // end if
            
    
        return true
        }
        
    
    }
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.scrollView.minimumZoomScale = 1
//        self.scrollView.maximumZoomScale = 6
        
        
        
        
        cmTitulo.isHidden = true
        cmTextfield.isHidden = true
        
        precio.delegate = self
        precioUSD.delegate = self
        cantidadEnCaja.delegate = self
        cajas.delegate = self
        libras.delegate = self
        categoriaField.delegate = self
        cbmField.delegate = self
//        confirmarField.delegate = self
        
      if existe == false {
        
        
        if continuar == true {
            
            descripcion.becomeFirstResponder()
        } else {
            suplidorLabel.becomeFirstResponder()
            
        }
        if fromMenuaCustome == true {
         EntradaReferencia.becomeFirstResponder()
        }
        
        }
        
        
        
        
        
        if noSequence == false { // si estas creando un articulo normal
            cdbLabel.isHidden = true
            codigoDeBarrra.isHidden = true
            cdbTextField.isHidden = true
        } else {
            
            cdbLabel.isHidden = true
            cdbTextField.isHidden = false
        }
        
        
     
        /////  jump textfields with enter
        
      
        self.descripcion.nextField = self.cantidadEnCaja
        self.cantidadEnCaja.nextField = self.cajas
        self.cajas.nextField = self.cbmField
        self.cbmField.nextField = self.precio
         self.calle.nextField = self.descripcion
        
        
        if swichPrecios.isOn {
        self.cbmField.nextField = self.precioUSD
        } else {
              self.cbmField.nextField = self.precio
           
        }
        
        if localSup == "LOCAL" {
            self.suplidorLabel.nextField = self.calle
        }
        if localSup == "FACTORIA" {
             self.suplidorLabel.nextField = self.descripcion
          
        }
            
            
            
            //}
            
//        self.field1.nextField = self.field2
//        self.field2.nextField = self.field3
//        self.field3.nextField = self.field4
//        self.field4.nextField = self.field1
//
        
       _ = CustomPhotoAlbum()
        customPedido = false
        fromMenua = false
        
        haveFoto = false

    
        
        
        ppv.text = ""
        ordenar.isHidden = true
        categoriaField.delegate = self
        fromInv = false
        
      
        
        if let tran = userD.object(forKey: "desde") as? Bool {     // averiguar que es tran

            if tran == true {
                fromInv = tran
                fromDetPedCrear = false
                fromMenuaCustome = false
                   print(tran)
            } else {
                   print(tran)   // lol delete
            fromInv = false
            }
        
        }
       
        
     
        
        

        
        if switchConfirmar.isOn == false {
            confirmarField.text = ""
            confirmarField.backgroundColor = UIColor.groupTableViewBackground
            confirmarField.isUserInteractionEnabled = false
            

        }
        
        
        if switchCategoria.isOn {
            // change background
            categoriaField.backgroundColor = UIColor.white
            
            if continuar == true {
                
                categoriaField.isUserInteractionEnabled = true
            } else {
                categoriaField.text = ""
                categoriaField.isUserInteractionEnabled = true
            }
            
        
            
        } else {
            // change background
            categoriaField.text = ""

            categoriaField.backgroundColor = UIColor.groupTableViewBackground
                        categoriaField.isUserInteractionEnabled = false
            
        }
        
        
        
        
        if swichPrecios.isOn {
            // change background
            precioUSD.backgroundColor = UIColor.white
            precio.backgroundColor = UIColor.groupTableViewBackground
            precio.text = ""
            precio.isUserInteractionEnabled = false
            precioUSD.isUserInteractionEnabled = true
            cantidadTotal.text = ""
        } else {
            // change background
            precioUSD.backgroundColor = UIColor.groupTableViewBackground
            precio.backgroundColor = UIColor.white
             precioUSD.text = ""
            precioUSD.isUserInteractionEnabled = false
            precio.isUserInteractionEnabled = true
            cantidadTotal.text = ""
        }
        
        
        do {
            let searchResult10 = try DatabaseController.getContext().fetch(fetchRequestVia)
            for result in searchResult10 as [Viaje] {
                
                arrayViajes.append(result.nombreDelViaje!)
                
                
            }
            
        }catch {
            //errorxg-t
        }
        
        
        
        
        
        
        pickerViaje.delegate = self
        pickerViaje.dataSource = self
//        blurscreen.isHidden = true
        callViajes()
        if let varViaje = userD.object(forKey: "nombreDelViaje") as? String {
            
            nombreDeViaje.text = varViaje
        }
        
        
        if continuar == false {
           LocalSuplidorLabel.text = localSup
       
        

        if localSup == "" {
            LocalSuplidorLabel.text = "LOCAL"
        } else {
            
            
        }
             SecRefLabel.text = secReferencia
        }
        // end if continuar
        
//        SecRefLabel.text = secReferencia
        
        if noSequence == true {
            
            EntradaReferencia.isHidden = false
           
        } else {
            EntradaReferencia.isHidden = true
        }
        
       
        
        if existe == false {
            
            if fromDetPedCrear == true {
            
         exitePedido = ""
                
                print("ESTE ES EL PEDIDO AGREGAR : \(secPedido)")
            }
            
            
                do {
                    let searchresult1 = try DatabaseController.getContext().fetch(fetchRequestCon)
        
        
                    for result1 in searchresult1 as [Configuracion] {
        
                        if result1.tipo == "principal" {
        
                            secrefnum = result1.refSecNum
                           
                            transferPedido = String(result1.secuenciaPedido)
                            
                            reflet = result1.refLet!
                           
                            
                            
                            if continuar == true {
                              ////////////////////////////////////

                                
                                do {
                                    
                                    let searchResult8 = try DatabaseController.getContext().fetch(fetchRequestRef)
                                    
                                    for result8 in searchResult8 as [Referencia] {
                                        if result8.suplidor == suplidorLabel.text {
                                        
                                            
                                            
                                            if result8.nombreDeFotoTargeta != nil {
                                                nomfototar = result8.nombreDeFotoTargeta!
                                            
                                            
       
                                                    
                                                    
                                                let name = nomfototar   //?.replacingOccurrences(of: "", with: "")
                                                    
//                                                imagenDeTargeta.image = getUIImage(asset: ((images[nomfototar] ?? images["nophoto.jpg"])!))
//                                                imagenDeTargeta.image = getUIImage(asset: (images[nomfototar]!))
                                                        
                                                if nomfototar != nil {
                                                    imagenDeTargeta.image = getUIImage(asset: (images[nomfototar]!))
                                                } else {
                                                    imagenDeTargeta.image = #imageLiteral(resourceName: "nophoto")
                                                }
                                                        
                                                        
                                                
                                                targeta = true
                                            
                                            }
                                            
                                        }
                                    }
                                    
                                        
                                            } catch {
                                                print("Error")
                                            }
                                
                                ////////////////////////////////////////
                                
                                
                                
                                
                                if LocalSuplidorLabel.text == "FACTORY" {
                                    factoriabool = true
                                secReferencia = "\(reftwoparts)\(result1.refSecNum)"
                                } else {
                                    factoriabool = false
                                    secReferencia = "\(reflet)-\(result1.refSecNum)"
                                }
                                
                                SecRefLabel.text = secReferencia
                                suplidorField(Any.self)
                                continuar = false  // CHANGED WARNING
                                

                                
                                
                                
                                
                                
                                    if suplidorLabel.text != nil {
                                    
                                    }
                                
                                
                                
                                } else {
                           
                                
                                
                                
                                secReferencia = "\(result1.refLet!)-\(result1.refSecNum)"
                            
                            
                       
                            SecRefLabel.text = secReferencia
                                conteoContenedor = getcbmtotal(suplidorLabel.text!)
                                

                                let a = 67.00
                                let b = conteoContenedor
                                let c = conteoContenedor / a
                                let d = c.rounded(.up)
                                print("\(d)")
                                let e = (d * a) - b
                                print ("Faltan \(e) CBM para Completar el contenedor")
                                var h = String()
                                if e <= 1 {
                                    h = "       SOBRAN \(String(format: "%.2f", arguments: [e])) CBM DEL CONTENEDOR"
                                } else {
                                    h = "       FALTAN \(String(format: "%.2f", arguments: [e])) CBM PARA COMPLETAR"
                                }
                                
                                
                               totalcontenedor.text = "TOTAL CBM:\(conteoContenedor)    TOTAL CNTR:" + String(format: "%.2f", arguments: [c]) + h
                                
                                
                                
              
                           continuar = false
                        }
                       
                            
                      }
                    }
        
                }catch {
                    
        }

            
            
            
        } else {   // IF EXISTE TRUE
            
            cdbLabel.isHidden = false
            cdbTextField.isHidden = true
            codigoDeBarrra.isHidden = false
            
             ordenar.isHidden = false

            haveFoto = false
            
            if exitePedido == "" {
                
                do {
                    let searchresult1 = try DatabaseController.getContext().fetch(fetchRequestCon)
                    
                    
                    for result1 in searchresult1 as [Configuracion] {
                        
                        if result1.tipo == "principal" {
                           
                                if let cusped = userD.object(forKey:  "customPedido") as? String {
                                    secPedido = cusped
                                    customPedido = true
                                    
                                } else {
                                    secPedido = String(result1.secuenciaPedido)
                                 }
                            
                            
                          
                        }
                        
                        
                    }
                } catch {
                    print("Error")
                }
                
                ordenar.setTitle("AGREGAR A PEDIDO      NUM: \(secPedido)", for: .normal)
                
            } else {
                secPedido = exitePedido
                  ordenar.setTitle("ACTUALISAR PEDIDO    NUM: \(secPedido)", for: .normal)
                    ordenar.setTitleColor(UIColor.white, for: .normal)
                ordenar.backgroundColor = UIColor.blue
                existe = true


                ordenar.isHidden = true

                
              
                
            }

           
            
            do {
             
                let searchResult8 = try DatabaseController.getContext().fetch(fetchRequestRef)
                
                for result8 in searchResult8 as [Referencia] {
                    if result8.referencia == secReferencia {
                        
                        oldReferencia = result8.referencia!
                        
                        
                       

                            cmTextfield.text = "\(result8.tamanoencm)"
              
                        
                        
                        
                        
                        if let nmft = result8.nombreDeFoto1 {
                            print ("que es: \(nmft)")
                            
                            nomfoto1 = nmft  //result8.nombreDeFoto1!
                            labelFoto.text = nomfoto1
                        }
                        
                        cantidadEnCaja.text = "\(result8.cantidadEnCaja)"
                        descripcion.text = result8.descripcion
                        cajas.text = "\(result8.caja)"
//                        if result8.cbm != nil {
                        cbmField.text = "\(result8.cbm)" 
//                        }
                       
                        
                        
                        print("PRECIO PPV: \(result8.ppv)")
                        
                        let cjww = Double(cajas.text!)!
                        let cbww = Double(cbmField.text!)!
                        let res = cjww * cbww
                        totalCbmLabel.text = "\(res)"
                        cbm = cbmField.text!
                        
                        
                        cdbLabel.isHidden = false
                        codigoDeBarrra.isHidden = false
                        
                        if result8.codigoDeBarra > 0 {
                            cdbLabel.text = "\(result8.codigoDeBarra)"
                        }
                        
//                        if result8.codigoDeBarra != nil {
//                            codigoDeBarrra.isHidden = false
//                            cdbLabel.isHidden = false
//
//                        cdbLabel.text = "\(result8.codigoDeBarra)"
//                            if cdbLabel.text == "0" {
//                                cdbLabel.isHidden = true
//                                codigoDeBarrra.isHidden = true
//                            }
//                        } else {
//                            cdbLabel.isHidden = true
//                            codigoDeBarrra.isHidden = true
//                            cdbLabel.text = ""
//                        }
                        
                        
                        let prmb = result8.precioRmb
                       let pusd = result8.precioUsd

                        
                        if prmb <= 0 && pusd > 0 {
                          precioUSD.text = "\(pusd)"
                             swichPrecios.setOn(true, animated: true)
                        }
                        
                        if prmb > 0 && pusd <= 0 {
                             swichPrecios.setOn(false, animated: true)
                             precio.text = "\(prmb)"
                        }
  
                        print("RMB \(prmb)")
                        print("USD \(pusd)")
                        
                        
                        if let colo = result8.colores {
                        
                            totalcolors = []
                            ColoresOutlet.forEach { (button) in
                                UIView.animate(withDuration: 0.3, animations: {
                                    button.isHidden = !button.isHidden
                                    self.view.layoutIfNeeded()
                                })
                            }
                            var tempcolor = String()
                            tempcolor = colo //result8.colores!
                        
                            let arr1 = tempcolor.components(separatedBy: ",")
//   var arrayColors = ["BLANCO","NEGRO","MARRON","AZUL","GRIS","MAMEY","AMARILLO","ROJO","ROSADO","VERDE","AZULCIELO","MORADO","CREMA"]
//                          print("\(arr1)")
                            for i in arr1 {
                            
                                    if let index = arr1.index(of: i) {
                                        print(index)
                                        totalcolors.append(i)
                                        let nam = "\(i.lowercased())c.png"
                                       
                                        switch i.lowercased() {
                                            
                                        case "blanco" :
                                                blanco.setImage(UIImage(named: nam), for: .normal)
                                        print("blanco")
                                            
                                        case "negro" :
                                            black.setImage(UIImage(named: nam), for: .normal)
                                        print("negro")
                                            
                                        case "marron" :
                                            marron.setImage(UIImage(named: nam), for: .normal)
                                            print("marron")
                                            
                                        case "azul" :
                                            azul.setImage(UIImage(named: nam), for: .normal)
                                            print("azul")
                                            
                                        case "gris" :
                                            gris.setImage(UIImage(named: nam), for: .normal)
                                            print("gris")
                                            
                                        case "mamey" :
                                            mamey.setImage(UIImage(named: nam), for: .normal)
                                            print("mamey")
                                            
                                        case "amarillo" :
                                            amarillo.setImage(UIImage(named: nam), for: .normal)
                                            print("amarillo")
                                        case "rojo" :
                                            rojo.setImage(UIImage(named: nam), for: .normal)
                                             print("rojo")
                                            
                                        case "rosado" :
                                            rosado.setImage(UIImage(named: nam), for: .normal)
                                            print("rosado")
                                            
                                        case "verde" :
                                            verde.setImage(UIImage(named: nam), for: .normal)
                                             print("verde")
                                            
                                        case "azulcielo" :
                                            azulcielo.setImage(UIImage(named: nam), for: .normal)
                                            print("azulcielo")
                                            
                                        case "morado" :
                                            morado.setImage(UIImage(named: nam), for: .normal)
                                            print("morado")
                                            
                                        case "crema" :
                                            crema.setImage(UIImage(named: nam), for: .normal)
                                            print("crema")
                                            
                                        default:
                                            print ("Error")
                                            
                                            
                                        }
                                       
                                        
                                        
                                
                                
                                
                                
                                }
                                 
                                  
                                    
                             
                                
                                
                            }
                            
                            
                            
                            
                        
                       
                        
                        
                        } else {
                           
                        }
                        
                        
                        
                        
                        
                        if let existecalle = result8.calle {
                            calle.text = existecalle
                        }
                        
                        
                        /////
                        
                        
                        if let name = nomfoto1 {    //.replacingOccurrences(of: "", with: "")
                         
                        
//                        if nomfoto1 != "" {
//                            ImageView.image = getUIImage(asset: (images[name]!))
//                        } else {
//                            ImageView.image = #imageLiteral(resourceName: "nophoto")
//                        }
                        
//                        ImageView.image = getUIImage(asset: ((images[name] ?? images["nophoto.jpg"])!))
                            
//                        ImageView.image = getUIImage(asset: (images[imgNamItem]!))
                        
                        /////
                        
    }
//                        ///////////////////////////
                        // get pictures with local indentifier
                        
                        if let varfoto1 = result8.fotoReferencia {
                               let asset = PHAsset.fetchAssets(withLocalIdentifiers: [varfoto1], options: nil)
                            fotoReferencia = result8.fotoReferencia
                            if asset.count > 0 {
                                foto.image = getUIImage(asset: asset[0])
                                
                                if self.ImageView.image != nil {
                                    let pictureTap = UITapGestureRecognizer(target: self, action: #selector(RegistrarReferencia.imageTapped(_:)))
                                    ImageView.addGestureRecognizer(pictureTap)
                                    ImageView.isUserInteractionEnabled = true
                                }
                                
                            }
                       
                        
                        }
                        //////////////////
                        
                        
//                         targeta   getting picture with picture name
                        if let varfoto2 = result8.nombreDeFotoTargeta {

                            let name = varfoto2   //?.replacingOccurrences(of: "", with: "")

                            if varfoto2 != "" {
                                ImageViewTar.image = getUIImage(asset: (images[name]!))
//                                imagenDeTargeta.image = getUIImage(asset: (images[nomfototar]!))
                            } else {
                                ImageViewTar.image = #imageLiteral(resourceName: "nophoto")
                            }


                            nomfototar = result8.nombreDeFotoTargeta!

                            if self.ImageViewTar.image != nil {

                                let pictureTap1 = UITapGestureRecognizer(target: self, action: #selector(RegistrarReferencia.imageTapped(_:)))
                                ImageViewTar.addGestureRecognizer(pictureTap1)
                                ImageViewTar.isUserInteractionEnabled = true
                            }
                        }

                        
                        
                        ////////////////////
                        libras.text = "\(result8.libras)"
                        
                        
                        categoriaField.text = "\(result8.porcientoAdicional)"
                        
                                               secrefnum = result8.savedRefNum
                        
                        
                        reflet = result8.savedRefLet!

                        
                        
                        nombreDeViaje.text = result8.via?.nombreDelViaje  // get viaje from that referencia
                       
                        suplidorLabel.text = result8.suplidor
              
                        if result8.llevaPocientoAdicional == true {
                            switchCategoria.setOn(true, animated: true)
                            categoriaField.isUserInteractionEnabled = true
                            categoriaField.backgroundColor = UIColor.white

                        } else {
                            switchCategoria.setOn(false, animated: true)
                            categoriaField.text = ""
                            categoriaField.isUserInteractionEnabled = false
                            categoriaField.backgroundColor = UIColor.groupTableViewBackground
                        }
                        
                        
                        let letters = CharacterSet.letters
                        let digits = CharacterSet.decimalDigits
                        
                        var letterCount = 0
                        var digitCount = 0
                        
                        let phrase = "\(String(describing: result8.suplidor))"
                        for uni in phrase.unicodeScalars {
                
                            if letters.contains(uni) {
                                letterCount += 1
                            } else if digits.contains(uni) {
                                digitCount += 1
                            }
                        }
                        print("DIGITS: \(letterCount) Numbers: \(digitCount)")
                        if digitCount > 1 {
                          LocalSuplidorLabel.text = "LOCAL"
                            factoriabool = false
                        } else {
                            factoriabool = true
                            LocalSuplidorLabel.text = "FACTORIA"
                            calle.text = "N/A"
                            
                        }
                        
                        
                        
                        if result8.empaqueConMadera == "SI" {
                            switchEmpaque.setOn(true, animated: true)
                        }
                        
                        if result8.llevaSelectivo == true {
                            SwitchSelectivo.setOn(true, animated: true)
                        }
                        if result8.llevaSelectivo == false {
                            SwitchSelectivo.setOn(false, animated: true)

                            
                        }
                        if result8.formaDeEmpaque == "SI" {
                            switchEmpaqueSeparado.setOn(true, animated: true)
                        }
                        
                        if let obs = result8.observacion {
                            confirmarField.text = obs
                        }
                        
                        
                        
                        if result8.confirmacion == true {
                            switchConfirmar.setOn(true, animated: true)
                            confirmarField.backgroundColor = UIColor.white
                            confirmarField.isUserInteractionEnabled = true

                        } else {
                            
                            switchConfirmar.setOn(false, animated: true)
                            confirmarField.text = ""
                            confirmarField.backgroundColor = UIColor.groupTableViewBackground
                            confirmarField.isUserInteractionEnabled = false
                            
                        }
                        
                      
                        if swichPrecios.isOn {
                            
                            _ = calcularppv(Double(precioUSD.text!)!)    // use calcularppv(35)
                            
                            let ct = Double(cantidadEnCaja.text!)!
                            let cj = Double(cajas.text!)!
                            let pr = Double(precioUSD.text!)!
                            
                            cantidadTotal.text = "\(ct * cj)"
                            let ctt = Double(cantidadTotal.text!)!
                            totalUsd.text = "\(ctt * pr)"
                            totalRmb.text = "\(ctt * pr * tazaRmb )"
                            precio.text = "\(pr * tazaRmb)"
                            
                            
                            
                            
                            
                            precioUSD.backgroundColor = UIColor.white
                            precio.backgroundColor = UIColor.groupTableViewBackground
//                            precio.text = ""
                            precio.isUserInteractionEnabled = false
                            precioUSD.isUserInteractionEnabled = true
                            
                        } else {
                           // fund nill need to secure this variable
                        _ = calcularppv(Double(precio.text!)!)    //calcularppv(35)
                        let ct = Double(cantidadEnCaja.text!)!
                        let cj = Double(cajas.text!)!
                        let pr = Double(precio.text!)!
                        cantidadTotal.text = "\(ct * cj)"
                        let ctt = Double(cantidadTotal.text!)!
                        totalRmb.text = "\(ctt * pr)"
                        totalUsd.text = "\(ctt * pr / tazaRmb)"
                        let cambioUsd = Double(precio.text!)!
                            
                            
                        
                        precioUSD.text = "\(cambioUsd / tazaRmb)"
                            
                            precioUSD.backgroundColor = UIColor.groupTableViewBackground
                            precio.backgroundColor = UIColor.white
//                            precioUSD.text = ""
                            precioUSD.isUserInteractionEnabled = false
                            precio.isUserInteractionEnabled = true


                        }
                        
                        
                        if swichPrecios.isOn {
                            precioUsdChange(self)
                        } else {
                            precioRmbCambio(self)
                            
                        }
                        //////////////
                       
                        for i in tipo[0..<tipo.count] {

                            if result8.categoria == i {
                                
                            let p = tipo.index(of: i)
                                
                                tipoDeMercanciaSegment.selectedSegmentIndex = p!
                            tipoMercancia = result8.categoria!
                               
                                
                            }
                            
                        }
                        
                        if tipoDeMercanciaSegment.selectedSegmentIndex == 3 {
                            cmTitulo.isHidden = false
                            cmTextfield.isHidden = false
                        } else {
                            cmTitulo.isHidden = true
                            cmTextfield.isHidden = true
                        }
                      //////////
                        
                    }
                    
                    
                    
                    
                }
                
                
                
            } catch {
                
                
            }
            
            if fromPedido == true {
                
                do {
                    let searchresult = try DatabaseController.getContext().fetch(fetchRequestHis)
                    
                    for resu in searchresult as [Pedidohistorico] {
                        print(" cantidad de enbtradas en historico BD \(searchresult.count)")
                        
                        if Int32(exitePedido)! == Int32(resu.numerodepedido!)! &&  SecRefLabel.text == resu.referencia! {
                          
                           cantidadTotal.text = "\(resu.cantidadtotal!)"
                            cajas.text = "\(resu.cajas!)"
                            cantidadEnCaja.text = "\(resu.cantidadencaja!)"
                            if resu.moneda != "RMB $ " {
                            swichPrecios.isOn = true
                              
                                
                                precioUSD.backgroundColor = UIColor.white
                                precio.backgroundColor = UIColor.groupTableViewBackground
                               
                                precio.isUserInteractionEnabled = false
                                precioUSD.isUserInteractionEnabled = true
                               
                                
                            precioUSD.text = "\(resu.precio!)"
                                precioUsdChange((Any).self)
                            } else {
                               precio.text = "\(resu.precio!)"
                                precioRmbCambio((Any).self)
                            }
                           
                         
                            
                        }
                    }
                } catch {
                    print("ERROR")
                    
                }
                
                
                
                
                
                
                
                
                
            }
            
            
            
            
                                    conteoContenedor = getcbmtotal(suplidorLabel.text!)
                                    let a = 67.00
                                     let b = conteoContenedor
                                    let c = conteoContenedor / a
                                        let d = c.rounded(.up)
                                        print("\(d)")
                                        let e = (d * a) - b
//                                         print ("Faltan \(e) CBM para Completar el contenedor")
            
            
            var h = String()
            if e <= 1 {
                h = "       SOBRAN \(String(format: "%.2f", arguments: [e])) CBM DEL CONTENEDOR"
            } else {
                h = "       FALTAN \(String(format: "%.2f", arguments: [e])) CBM PARA COMPLETAR"
            }
            
            
            totalcontenedor.text = "TOTAL CBM:\(conteoContenedor)    TOTAL CNTR:" + String(format: "%.2f", arguments: [c]) + h
            
            
            
            
        }
        
        
        
    } // END VIEWDIDLOAD
    
    enum colores: String {
        case blanco = "blanco"
        case negro = "negro"
        case marron = "marron"
        case azul = "azul"
        case gris = "gris"
        case mamey = "mamey"
        case amarillo = "amarillo"
        case rojo = "rojo"
        case rosado = "rosado"
        case verde = "verde"
        case azulcielo = "azulcielo"
        case morado = "morado"
        case crema = "crema"
        
//        "BLANCO","NEGRO","MARRON","AZUL","GRIS","MAMEY","AMARILLO","ROJO","ROSADO","VERDE","AZULCIELO","MORADO"
    }
    
    
  
    @IBAction func SeleccionoColores(_ sender: UIButton) {
        ColoresOutlet.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
        
        print ("ESTOS SON LOS COLORES \(totalcolors)")
        
    }
    
    
    
    
    
    
    
    
    @IBAction func cdbDidEnd(_ sender: Any) {
        
        let b = cdbTextField.text?.count
        
    if cdbTextField.text != "" {
  
        if b! <= 11 {
             cdbTextField.becomeFirstResponder()
            let refreshAlert = UIAlertController(title: "ALERTA CODIGO INCOMPLETO ", message: """
                                                                                             Codigo de Barra EAN - 13
                                                                                     Esta Inconpleto Porfavor Completar
                                                                                     deve digitar 12 digitos
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
                
                print("OK, FUE SELECIONADO")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            return
            
            
        }
        
        } // end b <= 0
        
    }
    
    
    
    @IBAction func entradareferenciaEnd(_ sender: Any) {
        print("FINISH? COMAPRE")
        var refCompare = String()
//        var exiBool = Bool()
        
        if let retemp = EntradaReferencia.text {
            refCompare = retemp
        }
        
        do {
            let searchResult11 = try DatabaseController.getContext().fetch(fetchRequestRef)
            for result in searchResult11 as [Referencia] {
                if refCompare.uppercased() == result.referencia {
                    print("NO PUEDE PROCEDER")
//                    exiBool = true
//                    EntradaReferencia.text = ""
                    EntradaReferencia.becomeFirstResponder()
                    //////////
                    let refreshAlert = UIAlertController(title: "ALERTA CODIGO EXISTENTE", message: """
                                                                                     El numero de referencia digitado ya existe
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        //            self.salvarNuevoSuplidor(self)
                        print("OK, FUE SELECCIONADO")
                        return
                    }))
                    
                  
                    
                    present(refreshAlert, animated: true, completion: nil)
                   
                    
                    /////////
                }
                
            }
            
        } catch {
            print("Error:")
        }
       
       
        
        
    }
    
    
    
    
    @IBAction func colorprecionado(_ sender: UIButton) {
        guard let title = sender.currentTitle, let color = colores(rawValue: title) else {
            return
        }
        
        switch color {
        case .blanco:
            if (blanco.currentImage?.isEqual(UIImage(named: "blanco.png")))! {
                totalcolors.append("BLANCO")
                blanco.setImage(UIImage(named: "blancoc.png"), for: .normal)
            } else {
                 if let index = totalcolors.index(of: "BLANCO") {
                            totalcolors.remove(at: index)
                }
                blanco.setImage(UIImage(named: "blanco.png"), for: .normal)
            }
            
            
          
            
        case .negro:
            

            
            if (black.currentImage?.isEqual(UIImage(named: "negro.png")))! {
                totalcolors.append("NEGRO")
                black.setImage(UIImage(named: "negroc.png"), for: .normal)
            } else {
                if let index = totalcolors.index(of: "NEGRO") {
                    totalcolors.remove(at: index)
                }
                black.setImage(UIImage(named: "negro.png"), for: .normal)
            }
           
         
        
            case .marron:
            
                if (marron.currentImage?.isEqual(UIImage(named: "marron.png")))! {
                    totalcolors.append("MARRON")
                    marron.setImage(UIImage(named: "marronc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "MARRON") {
                        totalcolors.remove(at: index)
                    }
                    marron.setImage(UIImage(named: "marron.png"), for: .normal)
                }
            
            
             case .azul:
                if (azul.currentImage?.isEqual(UIImage(named: "azul.png")))! {
                     totalcolors.append("AZUL")
                    azul.setImage(UIImage(named: "azulc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "AZUL") {
                        totalcolors.remove(at: index)
                    }
                    azul.setImage(UIImage(named: "azul.png"), for: .normal)
                }
                
           
           
               case .gris:
                if (gris.currentImage?.isEqual(UIImage(named: "gris.png")))! {
                    totalcolors.append("GRIS")
                    gris.setImage(UIImage(named: "grisc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "GRIS") {
                        totalcolors.remove(at: index)
                    }
                    gris.setImage(UIImage(named: "gris.png"), for: .normal)
                }
                
           
            
            case .mamey:
                if (mamey.currentImage?.isEqual(UIImage(named: "mamey.png")))! {
                    totalcolors.append("MAMEY")
                    mamey.setImage(UIImage(named: "mameyc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "MAMEY") {
                        totalcolors.remove(at: index)
                    }
                    mamey.setImage(UIImage(named: "mamey.png"), for: .normal)
                }
         
            
            case .amarillo:
                if (amarillo.currentImage?.isEqual(UIImage(named: "amarillo.png")))! {
                     totalcolors.append("AMARILLO")
                    amarillo.setImage(UIImage(named: "amarilloc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "AMARILLO") {
                        totalcolors.remove(at: index)
                    }
                    amarillo.setImage(UIImage(named: "amarillo.png"), for: .normal)
                }
          
            
            case .rojo:
                if (rojo.currentImage?.isEqual(UIImage(named: "rojo.png")))! {
                     totalcolors.append("ROJO")
                    rojo.setImage(UIImage(named: "rojoc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "ROJO") {
                        totalcolors.remove(at: index)
                    }
                    rojo.setImage(UIImage(named: "rojo.png"), for: .normal)
                }
         
        
        case .rosado:
            
           
            if (rosado.currentImage?.isEqual(UIImage(named: "rosado.png")))! {
                 totalcolors.append("ROSADO")
                rosado.setImage(UIImage(named: "rosadoc.png"), for: .normal)
            } else {
                if let index = totalcolors.index(of: "ROSADO") {
                    totalcolors.remove(at: index)
                }
                rosado.setImage(UIImage(named: "rosado.png"), for: .normal)
            }
            
           
           case .verde:
            if (verde.currentImage?.isEqual(UIImage(named: "verde.png")))! {
                 totalcolors.append("VERDE")
                verde.setImage(UIImage(named: "verdec.png"), for: .normal)
            } else {
                if let index = totalcolors.index(of: "VERDE") {
                    totalcolors.remove(at: index)
                }
                verde.setImage(UIImage(named: "verde.png"), for: .normal)
            }
            
         
            
             case .azulcielo:
                if (azulcielo.currentImage?.isEqual(UIImage(named: "azulcielo.png")))! {
                     totalcolors.append("AZULCIELO")
                    azulcielo.setImage(UIImage(named: "azulcieloc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "AZULCIELO") {
                        totalcolors.remove(at: index)
                    }
                    azulcielo.setImage(UIImage(named: "azulcielo.png"), for: .normal)
                }
           
            
             case .morado:
                
                if (morado.currentImage?.isEqual(UIImage(named: "morado.png")))! {
                     totalcolors.append("MORADO")
                    morado.setImage(UIImage(named: "moradoc.png"), for: .normal)
                } else {
                    if let index = totalcolors.index(of: "MORADO") {
                        totalcolors.remove(at: index)
                    }
                    morado.setImage(UIImage(named: "morado.png"), for: .normal)
                }
          
            
             case .crema:
            
            if (crema.currentImage?.isEqual(UIImage(named: "crema.png")))! {
                totalcolors.append("CREMA")
                crema.setImage(UIImage(named: "cremac.png"), for: .normal)
            } else {
                if let index = totalcolors.index(of: "CREMA") {
                    totalcolors.remove(at: index)
                }
                crema.setImage(UIImage(named: "crema.png"), for: .normal)
            }
            
        
        }

        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
    @IBAction func takepicturetargeta(_ sender: Any) {
        
        TakePicture.shared.takePicture(sourceViewController: self) { image in
           self.imagenDeTargeta.image = image
            self.saveToLabrary2()
        }
        
            
//        targeta = true
//        haveFoto = false
//        /// tomar foto de targeta de presentacion
//        let image1 = UIImagePickerController()
//        image1.delegate = self
//
//        image1.sourceType = UIImagePickerControllerSourceType.photoLibrary
//
//        image1.allowsEditing = false
//
//        self.present(image1, animated: true)
//        {
//
//        }
        ///////////////////////
        
        
       
        targeta = true
        haveFoto = false
//        let image = UIImagePickerController()
//        image.delegate = self
        
//        image.sourceType = UIImagePickerControllerSourceType.camera
//
//        image.allowsEditing = false
        
//        self.present(image, animated: true)
//        {
//
//        }
 
        
        
        
        
        
        
        
    }
    
    @IBAction func tipoMercdidchannge(_ sender: Any) {
        if tipoDeMercanciaSegment.selectedSegmentIndex == 1 {
            switchCategoria.isOn = true
            categoriaField.isUserInteractionEnabled = true
            categoriaField.text = "70"
            categoriaField.backgroundColor = UIColor.white
         
            if (precio.text != nil) || (precio.text != nil) {
                
                   if swichPrecios.isOn {
                                 precioUsdChange(self)
                         } else {
                                 precioRmbCambio(self)
                
                   }
              }
            
            
        
            
            
            
            ////
            
            
            
        }
    }
    //////////// cancel without selecting a picture
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("SE CANCELO")
        haveFoto = Bool()
        targeta = Bool()
        eligio = false
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 
         print("HAVE PIC")
        
///////
     
        ////////
   
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
        {
           
            
            
            if haveFoto == true && targeta == false {
                foto.image = image

              
                
                
                if eligio != true {
                saveToLibrary()
//tiene = true
                    
                } else {
                   // get picture name from picker
                    
                    if #available(iOS 11.0, *) {
                                    let asset = info[UIImagePickerControllerPHAsset] as! PHAsset
                        let resources = PHAssetResource.assetResources(for: asset)
                        let orgFilename = (resources[0]).originalFilename
                                    print("File Name: ",orgFilename)
                        
                         self.nomfoto1 = orgFilename
                         self.labelFoto?.text = orgFilename
                        
                 }
            
                
          }
               
                //////////   'fetchAssets(withALAssetURLs:options:)' was deprecated in iOS 11.0: Will be removed in a future release
               ///'UIImagePickerControllerReferenceURL' was deprecated in iOS 11.0: Replace with public API: UIImagePickerControllerPHAsset
                if self.ImageView.image != nil {
                   
                    let pictureTap = UITapGestureRecognizer(target: self, action: #selector(RegistrarReferencia.imageTapped(_:)))
                    ImageView.addGestureRecognizer(pictureTap)
                    ImageView.isUserInteractionEnabled = true
                }
                    

                
               
            }
            
                
            if targeta == true && haveFoto == false {
               imagenDeTargeta.image = image
                saveToLabrary2()
//                  updateImagename()
                if self.ImageViewTar.image != nil {
                    
                    let pictureTap1 = UITapGestureRecognizer(target: self, action: #selector(RegistrarReferencia.imageTapped(_:)))
                    ImageViewTar.addGestureRecognizer(pictureTap1)
                    ImageViewTar.isUserInteractionEnabled = true
                    ///
                    
                   
                    
                    
                    ////
                    
                }
                
            }

        }
        else
        {

        }
        
        self.dismiss(animated: true, completion: nil)
        

        
        eligio = Bool()
        
        
    
    }
    
  
  
    
    @IBAction func takepict(_ sender: Any) {
      
        var takeBool : Bool = false
    ////////
        let refreshAlert = UIAlertController(title: "IMPORTAR DESDE", message: """
                                                                         Deseas Importar desde donde
                                                                         Libreria o Camara.
                                                                         """, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "CAMARA", style: .default, handler: { (action: UIAlertAction!) in
            self.haveFoto = true
            self.targeta = false
            let image = UIImagePickerController()
            image.delegate = self
            
            image.sourceType = UIImagePickerControllerSourceType.camera
            
            image.allowsEditing = false
            
            self.present(image, animated: true)
            {
             
            }
            print("CAMARA, FUE SELECCIONADO")
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "CANCELAR", style: .cancel, handler: { (action: UIAlertAction!) in
            print("CANCELAR , FUE SELECIONADO")
        }))
    
        refreshAlert.addAction(UIAlertAction(title: "LIBRERIA DE FOTOS", style: .default, handler: { (action: UIAlertAction!) in
            self.haveFoto = true
            self.targeta = false
            self.eligio = true
             let image = UIImagePickerController()
             image.delegate = self
             
             image.sourceType = UIImagePickerControllerSourceType.photoLibrary
             
             image.allowsEditing = false

             self.present(image, animated: true)
             {
      
             }
      
        print("LIBRERIA , FUE SELECCIONADO")
//                    DispatchQueue.global(qos: .background).async {
//                        // Background Thread
//                        DispatchQueue.main.async {
//                            // Run UI Updates or call completion block
//                           self.agregarAlpedidoDirecto = true
//
//                        }
//                    }
       
        
    }))
 
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
     
    func saveToLibrary() {
//                var temporal = String()                                           // 0.6 is 2MB PICTURE
        if let image = foto.image, let imageData = UIImageJPEGRepresentation(image, 0.3), let compressedJPGImage = UIImage(data: imageData) {
        
            //TODO: only save image if it's picture being taken NEED TO FIX
            PHPhotoLibrary.shared().savePhoto(image: compressedJPGImage, albumName: "Album", completion: { [weak self] (asset) in
//                print("123:# \(PHAssetResource.assetResources(for: asset!).first?.originalFilename)")
                self?.nomfoto1 = "\(PHAssetResource.assetResources(for: asset!).first!.originalFilename)"
               
                if let asset1 = asset,let name =  asset1.value(forKey: "filename") as? String {
                    self?.delegate?.updateImageWith(asset: asset1, name:  name)
                }
                
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                         self?.labelFoto.text = self?.nomfoto1
                        self!.fotoReferencia = asset?.localIdentifier
                        
                    }
                }

                
                       
            })
            
        }

               haveFoto = true
    //////////////////////
       
    
        
       
        
    }
    
    func saveToLabrary2() {
        
       ////
        
        ////
        
            if let image = imagenDeTargeta.image, let imageData = UIImageJPEGRepresentation(image, 0.6), let compressedJPGImage = UIImage(data: imageData) {
                
                //TODO: only save image if it's picture being taken
                PHPhotoLibrary.shared().savePhoto(image: compressedJPGImage, albumName: "Album", completion: { [weak self] (asset) in
                    self?.imgNamCard = "\(PHAssetResource.assetResources(for: asset!).first!.originalFilename)"
                    print("TARGETA PIC NOMBRE: \(self?.imgNamCard)")
                    if let asset = asset,let name =  asset.value(forKey: "filename") as? String {
                        self?.images[name] = asset
                        self?.delegate?.updateImageWith(asset: asset, name: name)
                        self?.nomfototar = name
                    }
                    
//
                    self!.fotoReferencia2 = asset?.localIdentifier   //  this is how to get the local indentifier
                })
            }
            
            targeta = true
            
            
       
     
        
        
        
        
    }
    
    @IBAction func bettermenu(_ sender: Any) {
     let fileManager = FileManager.default

        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("SDC FOTOS")
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
            print("directory DELETED")
        }else{
            print("Something wronge.")
        }
        
    }
    
    
    
    func callViajes() {
        
        
        
        do {
            let searchresult7 = try DatabaseController.getContext().fetch(fetchRequestVia)
        
            
            for result7 in searchresult7 as [Viaje] {
            
                if nombreDeViaje.text == result7.nombreDelViaje {
                
                
                
                selectivo = result7.selectivo
                aduana = result7.aduanaMasGastos
                flete = result7.fleteMaritimo
                gn = result7.ganaciaGeneral
                itebis = result7.impuestoItebis
                material = result7.materialRelleno
                tazaRmb = result7.tazaRmb
                tazaUsd = result7.tazaUsd
                
                }
                
                
                
            }
            
            
        }catch {
            
        }
        
        

        
        
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1 //arrayViajes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ultimoviaje2 = "\(arrayViajes[arrayViajes.count - 1 - row])"
        return arrayViajes[arrayViajes.count - 1 - row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nombreDeViaje.text = arrayViajes[arrayViajes.count - 1 - row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    @IBAction func suplidorField(_ sender: Any) {
        
        
        if suplidorLabel.text != "" {
            
            if existe == false {
            
            
            
            
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        var letterCount = 0
        var digitCount = 0
        let phrase = "\(suplidorLabel.text!)"
        for uni in phrase.unicodeScalars {
            
            if letters.contains(uni) {
                letterCount += 1
            } else if digits.contains(uni) {
                digitCount += 1
            }
        }
        if digitCount > 0 {
            LocalSuplidorLabel.text = "LOCAL"
             if continuar == false {
                 calle.text = ""
            }
            
            self.suplidorLabel.nextField = self.calle
             calle.isUserInteractionEnabled = true
            SecRefLabel.text = "\(reflet)-\(secrefnum)"
            reftwoparts = "\(reflet)-\(supinicials)"
            factoriabool = false
                    } else {
            
            if let suplab = suplidorLabel.text {
                supinicials = String(suplab.prefix(1))     // String(suplab.characters.first!)
            }
                             
          
            LocalSuplidorLabel.text = "FACTORIA"
              self.suplidorLabel.nextField = self.descripcion
            if suplidorLabel.text != "" {
                
                
                conteoContenedor = getcbmtotal(suplidorLabel.text!)
                
//                conteoContenedor = getcbmtotal(suplidorLabel.text!)
                let a = 67.00
                let b = conteoContenedor
                let c = conteoContenedor / a
                let d = c.rounded(.up)
                print("\(d)")
                let e = (d * a) - b
//                print ("Faltan \(e) CBM para Completar el contenedor")
                
                
                var h = String()
                if e <= 1 {
                    h = "       SOBRAN \(String(format: "%.2f", arguments: [e])) CBM DEL CONTENEDOR"
                } else {
                    h = "       FALTAN \(String(format: "%.2f", arguments: [e])) CBM PARA COMPLETAR"
                }
                
                
                totalcontenedor.text = "TOTAL CBM:\(conteoContenedor)    TOTAL CNTR:" + String(format: "%.2f", arguments: [c]) + h
                
//                var a = 68.00
//                var b = conteoContenedor
//                var c = conteoContenedor / a
//
//                totalcontenedor.text = "CBM:\(conteoContenedor) CONTEINER:\(c)"
            }
          factoriabool = true
            
            calle.text = "N/A"
            calle.isUserInteractionEnabled = false
            SecRefLabel.text = "\(reflet)-\(supinicials)\(secrefnum)"
            reftwoparts = "\(reflet)-\(supinicials)"
            
        }

        
            } // end existe
        
        }
        
    }
    
   
    

    
    @IBAction func cambiarviajeboton(_ sender: Any) {
      
        cambiarviaje()
          nombreDeViaje.text = ultimoviaje2
        let refreshAlert = UIAlertController(title: "ALERTA", message: """
                                                                                             Deve Salvar los Cambios
                                                                                            Para que sean PERMANENTES
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
            
            print("OK, FUE SELECIONADO")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func switchcategoria(_ sender: Any) {
      
               if switchCategoria.isOn {
            // change background
            categoriaField.backgroundColor = UIColor.white
            
            categoriaField.text = ""
            categoriaField.isUserInteractionEnabled = true
              
                
        } else {
                
                
            // change background
            if swichPrecios.isOn {
                precioUsdChange(self)
            } else {
                precioRmbCambio(self)
                
            }
                
                
                
            categoriaField.backgroundColor = UIColor.groupTableViewBackground
            categoriaField.text = ""
            categoriaField.isUserInteractionEnabled = false

        }

        
        
        
    }
    
    
    @IBAction func switchconf(_ sender: Any) {
        
        if switchConfirmar.isOn {
            // change background
            confirmarField.backgroundColor = UIColor.white
            
            confirmarField.text = ""
            confirmarField.isUserInteractionEnabled = true
            confirmarField.becomeFirstResponder()
            
        } else {
            // change background
            
            confirmarField.backgroundColor = UIColor.groupTableViewBackground
            confirmarField.text = ""
           confirmarField.isUserInteractionEnabled = false
            
        }
  
        
        
        
    }
    
    
    @IBAction func switchprecio(_ sender: Any) {
       
        if swichPrecios.isOn {
            // change background
            precioUSD.backgroundColor = UIColor.white
              precio.backgroundColor = UIColor.groupTableViewBackground
            precio.text = ""
            precio.isUserInteractionEnabled = false
             precioUSD.isUserInteractionEnabled = true
            precioUSD.becomeFirstResponder()
        } else {
            // change background
            precioUSD.backgroundColor = UIColor.groupTableViewBackground
            precio.backgroundColor = UIColor.white
            precioUSD.text = ""
              precioUSD.isUserInteractionEnabled = false
              precio.isUserInteractionEnabled = true
            precio.becomeFirstResponder()
        }
        
        
        
    }
    
    
    
   
    
    
    
    
    
    @IBAction func backbutton(_ sender: Any) {
        // NOTE: When ever you do an if statement with a bool value that is true you dont have to declare == true becouse
        // its already a true statement
    
        
        if let presenter = self.presentingViewController as? DetallePedido, fromPedido, !fromDetPedCrear {
            presenter.set = 1
            presenter.secPedido = secPedido
            presenter.commingback = true
        }
        
        if let presenter = self.presentingViewController as? DetallePedido, fromDetPedCrear {
            presenter.secPedido = secPedido
             presenter.set = 1
             presenter.commingback = true
            self.agregarApedido(self)
        }
        
        if let presenter = self.presentingViewController as? Menua {
            presenter.set = 1
    
        }
        
        if let presenter = self.presentingViewController as? InventarioGeneralVC {
            presenter.set = 1
            
            
        }
        self.dismiss(animated: true, completion: nil)



    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if fromPedido == true && fromDetPedCrear == false {
//
//            let guest = segue.destination as! DetallePedido
//
//            guest.secPedido  = secPedido
//
//        }
//
//        if self.fromDetPedCrear == true {
//            let guest = segue.destination as! DetallePedido
//
//            guest.secPedido  = secPedido
//            self.fromPedido = true
//            print("ESTE ES EL PEDIDO: \(self.secPedido)")
//            print("ESte es EXITS \(self.exitePedido)")
//
//            self.agregarApedido(self)
        
//        }
        
//        if self.fromConfirmar == true {
//            
////             performSegue(withIdentifier: "Registrar2Confirmar", sender: nil)
//            
//        }
        
        
    }
    
    
    @IBAction func tipoMercanciaSegement(_ sender: Any) {
      
        switch tipoDeMercanciaSegment.selectedSegmentIndex {
        case 0:
            tipoMercancia = "CRISTALERIA"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 1:
            tipoMercancia = "JUGUETES"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 2:
            tipoMercancia = "COSINA"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 3:
            tipoMercancia = "PELUCHE"
            cmTitulo.isHidden = false
            cmTextfield.isHidden = false
        case 4:
            tipoMercancia = "FLORES"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 5:
            tipoMercancia = "ESCOLARES"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 6:
            tipoMercancia = "GENERAL"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 7:
            tipoMercancia = "NAVIDAD"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 8:
            tipoMercancia = "SANVALENTIN"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        case 9:
            tipoMercancia = "CUMPLEANO"
            cmTitulo.isHidden = true
            cmTextfield.isHidden = true
        default :
            break
        }
        
        
        
    }
    
    func calcularppv(_ calprecio: Double) -> Double {         //CALCULAR PPV
       var salarioxHR = Double()
        var tamanocmC = Double()
        
        
        do {
            let searchresult7 = try DatabaseController.getContext().fetch(fetchRequestVia)
            
        
            for result7 in searchresult7 as [Viaje] {
                
                if nombreDeViaje.text == result7.nombreDelViaje {
                    tamanocmC = 0.00
                    
                    salarioxHR = result7.salarioxhora
                    if cmTextfield.text != "" {
                    if let tamaTemp = cmTextfield.text {
                        tamanocmC = Double(tamaTemp)!
                    }
                    }
                    
                    selectivo = result7.selectivo
                    
                    
                    aduana = result7.aduanaMasGastos
                    flete = result7.fleteMaritimo
                    
                    if switchCategoria.isOn {
                        if categoriaField.text != "" {
                        gn = Double("\(categoriaField.text!)")!
                        } else {
                            gn = result7.ganaciaGeneral
                        }
                    } else {
                          gn = result7.ganaciaGeneral
                    }
                    
                  
                    itebis = result7.impuestoItebis
                    
                    material = result7.materialRelleno
                    
                   
                    tazaUsd = result7.tazaUsd
                    tazaRmb = result7.tazaRmb
                    
                    prexlib = result7.materialRelleno
                    
                    
                    
                    
                }
                
                
                
            }
            
            
        }catch {
            
        }
        
            // CALCULAR
       
//        if switchCategoria.isOn {
//            if categoriaField.text != "" {
//            gn = Double(categoriaField.text!)!
//            }
//            }
        
        if swichPrecios.isOn {
            masfle = calprecio * flete/100 + calprecio
        } else {
            masfle = calprecio / tazaRmb * flete/100 + calprecio/tazaRmb
        }
        
        print("\(masfle)")
        
        let mastaza = masfle * tazaUsd
        
        
        var costo = 0.00
        var p = 0.00
        var p1 = 0.00
        var adu = 0.00
       
        
        if SwitchSelectivo.isOn {
           
           // mastaza = mastaza * (selectivo/100 + 1)
            adu = selectivo + aduana
        } else {
            adu = aduana

        }
        
        print("\(mastaza)")

        
        
        
        
        if libras.text != "" && cmTextfield.text != "" {
            
            var min = 60.00
            var can1hora = Double()
            var cmxmin = 10.00
            var trd = Double()
            var manoDeobra1Peluche = Double()
            var pt1 = 180.00
            var totalValorLibra = Double()
            var tiempo1PelucheMin = Double()
            var cos = Double()

            func calcularManoDeObra() -> Double {
        
                trd = Double(cmTextfield.text!)!/cmxmin  // tiempo de relleno en min de un peluche
                can1hora = min/trd
                
                tiempo1PelucheMin = Double(cmTextfield.text!)!/cmxmin
                manoDeobra1Peluche = salarioxHR/min*tiempo1PelucheMin
                
                
          
                
                return manoDeobra1Peluche
            }
            
            
            
            
          
           
           
            totalValorLibra = Double(libras.text!)! * prexlib
            let addExtra = calcularManoDeObra()
            
            cos = mastaza * adu/100 + mastaza
            costo = cos + totalValorLibra + addExtra
            
           
    
            
            
            
           
    
            
        } else {
          
            let cos = mastaza * adu/100 + mastaza
            costo = cos
            print("\(costo)")
        }
        
        
        
        p = costo * gn/100 + costo
        print("\(p)")
        
        p1 = p * itebis/100 + p
        print("\(p1)")
        
        

        
        
        // ADD DECIMAL POINT TO STRING    let str = String(format: "%.2f%%", rate)
        
        
        
        return p1

    }
    
    
    
    @IBAction func cantidadChange(_ sender: Any) {
      
        
        if cantidadEnCaja.text != "" {
            
            var tranfer = ""
            
//            let catv = cantidadEnCaja.text!
            
            if let cat = cantidadEnCaja.text {
                tranfer = String(cat.prefix(1))    // String(cat.characters.first!)
            }
            
            print(tranfer)
            
            if tranfer == "." {
                
            } else {

        
        
        
        
        if cantidadEnCaja.text != "" && precio.text != "" && cajas.text != "" {
            let ct = Int(cantidadEnCaja.text!)!
            let cj = Int(cajas.text!)!
            cantidadTotal.text = "\(ct * cj)"
            
            
            let pr = Double(precio.text!)!
            let ctt = Double(cantidadTotal.text!)!
            totalRmb.text = "\(ctt * pr)"
          } else if cantidadEnCaja.text != "" && cajas.text != "" {
                    let ct = Int(cantidadEnCaja.text!)!
                    let cj = Int(cajas.text!)!
                    cantidadTotal.text = "\(ct * cj)"
                    
//            let ctt = Double(cantidadTotal.text!)!
            
        } else {
            totalRmb.text = ""
            cantidadTotal.text = ""
        }
 
        
        
            } // end "."
        
       
        } //  end EMPRTY
            
        
    }
    
    @IBAction func cbmchanged(_ sender: Any) {
        
        if cbmField.text != "" {
            
            var tranfer = ""
            
//            let catv = cbmField.text
            
            if let cat = cbmField.text {
                tranfer = String(cat.prefix(1))
            }
            
            print(tranfer)
            
            if tranfer == "." {
                let compose = "0" + cbmField.text!
                cbmField.text = compose
                
                
                print("AKI DEVIERA PASAR ALGO")
            } else {
            
            
            
        
        
        
        
        
        
        
        if cbmField.text != "" && cajas.text != "" {
            let cjww = Double(cajas.text!)!
            let cbww = Double(cbmField.text!)!
            let res = cjww * cbww
            totalCbmLabel.text = "\(res)"
            cbm = cbmField.text!
            totalcbm = totalCbmLabel.text!
            print("\(cbm)")
            
        }
        
            }
        
        
        
        }
        
    }
    
    @IBAction func cajasChange(_ sender: Any) {
     
        if cajas.text != "" {
            
            var tranfer = ""
            

//            let catv = cajas.text
            
            if let cat = cajas.text {
                tranfer = String(cat.prefix(1))
            }
            
            print(tranfer)
            
            if tranfer == "." {
               
                
            } else {
                
 if cbmField.text != "" && cajas.text != "" {
    let cjww = Double(cajas.text!)!
    let cbww = Double(cbmField.text!)!
    let res = cjww * cbww
    totalCbmLabel.text = "\(res)"
    cbm = cbmField.text!
    print("\(cbm)")
    
    
    totalcbm = totalCbmLabel.text!
    
                }
                
    
        
        
        
        if cantidadEnCaja.text != "" && precio.text != "" && cajas.text != "" {
            let ct = Double(cantidadEnCaja.text!)!
            let cj = Double(cajas.text!)!
            

            
            
            let tot = ct * cj
            let newtot = Int(tot)
            cantidadTotal.text = "\(newtot)"
            
            
            
            
            
            //cantidadTotal.text = "\(ct * cj)"
            
            
            let pr = Double(precio.text!)!
            let ctt = Double(cantidadTotal.text!)!
            totalRmb.text = "\(ctt * pr)"
            
            
           } else if cantidadEnCaja.text != "" && cajas.text != "" {
                    let ct = Double(cantidadEnCaja.text!)!
                    let cj = Double(cajas.text!)!
             
                    let tot = ct * cj
                    let newtot = Int(tot)
                    cantidadTotal.text = "\(newtot)"
        
                } else {
            totalRmb.text = ""
            cantidadTotal.text = ""
        }
        
    
    
    
            }
    
        }
    
//        if cbmField.text == "" {
//            cbm = ""
//        }
        
    }
    
    
    
    
    @IBAction func precioRmbCambio(_ sender: Any) {
       
        if precio.text != "" {
            print("FILED CHANGE")
            
            
            var tranfer = ""
            
//            let catv = precio.text
            
            if let cat = precio.text {
                tranfer = String(cat.prefix(1))
            }
            
            print(tranfer)
            
            if tranfer == "." {
                
                let compose = "0" + precio.text!
                precio.text = compose
                
            } else {

        
        
        
        
        if precio.text != "" {
//        calcularppv(Double(precio.text!)!)
//        ppv.text = "\(calcularppv(Double(precio.text!)!))"
            let cal = Double(calcularppv(Double(precio.text!)!))
            
            ppv.text = String(format: "%.2f", arguments: [cal])
            
            
            
        } else {
        ppv.text = ""
            
        }
        if cantidadEnCaja.text != "" && cajas.text != "" && precio.text != "" {
       
            let ct = Double(cantidadEnCaja.text!)!
        let cj = Double(cajas.text!)!
        let pr = Double(precio.text!)!
          
            let tot = ct * cj
            let newtot = Int(tot)
            cantidadTotal.text = "\(newtot)"
        //cantidadTotal.text = "\(ct * cj)"
        let ctt = Double(cantidadTotal.text!)!
            
        totalRmb.text = String(format: "%.2f", arguments: [ctt * pr])
            
        totalUsd.text = String(format: "%.2f", arguments: [ctt * pr / tazaRmb])
        let cambioUsd = Double(precio.text!)!
            
            precioUSD.text = String(format: "%.3f", arguments: [cambioUsd / tazaRmb])
            

            
            
            
        } else if precio.text != "" {
            let cal1 = Double(calcularppv(Double(precio.text!)!))
            
            ppv.text = String(format: "%.2f", arguments: [cal1])
            
        } else {
           
            
            
            totalRmb.text = ""
            cantidadTotal.text = ""
            precioUSD.text = ""
            ppv.text = ""
        }
     
    
        
            }
        } else {   // if empty
            
            ppv.text = ""
            precioUSD.text = ""
            totalRmb.text = ""
            totalUsd.text = ""
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func categriaChange(_ sender: Any) {
        
       
       
        
        
        
       
        if categoriaField.text != "" {

            var tranfer = ""
            
//            let catv = categoriaField.text
            
                if let cat = categoriaField.text {
                    tranfer = String(cat.prefix(1))
                }
                
          
                
              print(tranfer)
                
            
            
            
            
            if tranfer == "." {
                
            } else {
            
            
        if precio.text == "" || precioUSD.text != "" {
    
            if swichPrecios.isOn {
            
                _ = calcularppv(Double(precioUSD.text!)!)
                ppv.text = "\(calcularppv(Double(precioUSD.text!)!))"
                
            
            } else if precio.text != "" || precioUSD.text == ""  {
                _ = calcularppv(Double(precio.text!)!)
                ppv.text = "\(calcularppv(Double(precio.text!)!))"
             
            
            }
      
            }
        
            } // end else "."
            
            
            
            
            
        } else { // IS empty
            print("No input")
        }
        
        
        
        
        
    }
    
    @IBAction func precioUsdChange(_ sender: Any) {
     
        if precioUSD.text != "" {
            
            var tranfer = ""
            
//            let catv = precioUSD.text
            
            if let cat = precioUSD.text {
                tranfer = String(cat.prefix(1))
            }
            
            print(tranfer)
            
            if tranfer == "." {
                let compose = "0" + precioUSD.text!
                precioUSD.text = compose
                
            } else {

        
        
        
        
        
        if precioUSD.text != "" {
         _ = calcularppv(Double(precioUSD.text!)!)
            let cal = Double(calcularppv(Double(precioUSD.text!)!))
            
         ppv.text = String(format: "%.2f", arguments: [cal])
        } else {
            
            ppv.text = ""
        }
        
        if cantidadEnCaja.text != "" && cajas.text != "" && precioUSD.text != "" {
            
            let ct = Double(cantidadEnCaja.text!)!
            let cj = Double(cajas.text!)!
            let pr = Double(precioUSD.text!)!
            let tot = ct * cj
            let newtot = Int(tot)
            cantidadTotal.text = "\(newtot)"
            let ctt = Double(cantidadTotal.text!)!
            
            totalUsd.text = String(format: "%.2f", arguments: [ctt * pr])
            
            totalRmb.text = String(format: "%.2f", arguments: [ctt * pr * tazaRmb ])
            
            
//            String(format: "%.2f", arguments: [pr * tazaRmb])
            precio.text = String(format: "%.3f", arguments: [pr * tazaRmb])
            
            
            
        } else {
            totalUsd.text = ""
            cantidadTotal.text = ""
            precio.text = ""
        }

                
            }
        } else {
            ppv.text = ""
            precio.text = ""
            totalRmb.text = ""
            totalUsd.text = ""
        }
        
        
        
        
        
        
    }
    
    @IBAction func librasChange(_ sender: Any) {
   
        
        if libras.text != "" {
            
            var tranfer = ""
            
//            let catv = libras.text
            
            if let cat = libras.text {
                tranfer = String(cat.prefix(1))
            }
        
            print(tranfer)
            
            if tranfer == "." {
                let compose = "0" + libras.text!
                libras.text = compose
                
            } else {

                
                
                
        if swichPrecios.isOn && precioUSD.text != "" && libras.text != "." {
            _ = calcularppv(Double(precioUSD.text!)!)
            ppv.text = "\(calcularppv(Double(precioUSD.text!)!))"
        } else if swichPrecios.isOn == false && precio.text != "" && libras.text != "." {
            _ = calcularppv(Double(precio.text!)!)
            ppv.text = "\(calcularppv(Double(precio.text!)!))"
        } else {
       
        
        
            if swichPrecios.isOn {
                precioUsdChange(self)
                } else {
                precioRmbCambio(self)
            
                }
            }
        
        
                
                
                
                
                
                
        }
        
        
        
        
        } else {
            
            ////
            
            if swichPrecios.isOn && precioUSD.text != "" && libras.text != "." {
                _ = calcularppv(Double(precioUSD.text!)!)
                
                ppv.text = "\(calcularppv(Double(precioUSD.text!)!))"
            } else if swichPrecios.isOn == false && precio.text != "" && libras.text != "." {
                _ = calcularppv(Double(precio.text!)!)
                ppv.text = "\(calcularppv(Double(precio.text!)!))"
            } else {
                
                
                
                if swichPrecios.isOn {
                    precioUsdChange(self)
                } else {
                    precioRmbCambio(self)
                    
                }
            }
            
           /////
            
        }// end if not empty
        
    
        
    
    
    }
    
    
    @IBAction func switchSelec(_ sender: Any) {
        
        // change background
        if swichPrecios.isOn {
            precioUsdChange(self)
        } else {
            precioRmbCambio(self)
            
        }
        
        
    }
   ////////////////////////////////////////////////
    
    
    
    
    @IBAction func suplidoddidendEdit(_ sender: Any) {
        
        do {
            
            let searchResult8 = try DatabaseController.getContext().fetch(fetchRequestRef)
            
            for result8 in searchResult8 as [Referencia] {
                if result8.suplidor == suplidorLabel.text {
                    if result8.nombreDeFotoTargeta != nil {
                        nomfototar = result8.nombreDeFotoTargeta!
                    }
                    
                    
                    if let varfoto = result8.nombreDeFotoTargeta {
                       
                        nomfototar = varfoto
                        
                        
                          //?.replacingOccurrences(of: "", with: "")
                        if varfoto != "" {
                            imagenDeTargeta.image = getUIImage(asset: (images[nomfototar]!))
                            targeta = true
                        } else {
                            imagenDeTargeta.image = #imageLiteral(resourceName: "nophoto")
                        }
                        
//                      imagenDeTargeta.image = getUIImage(asset: ((images[nomfototar] ?? images["nophoto.jpg"])!))
//                        imagenDeTargeta.image = getUIImage(asset: ((images[nomfototar]!)))

                        
                    }
                    
                    
                }
            }
            
            
        } catch {
            print("Error")
        }
    }
    
    
    @IBAction func agregarApedido(_ sender: Any) {
//        print("/////////////////////////////////")
//        print("ESTE ES EL PEDIDO: \(secPedido)")
//        print("ESte es EXITS \(exitePedido)")
        
       
        var numpertrans = Int32()
        
        func alertnow(numper: Int32) {
            
           
                let refreshAlert = UIAlertController(title: " AVISO ", message: """
                    Este Articulo Ya esta en tu PEDIDO Numero: \(numper)
                    """, preferredStyle: UIAlertControllerStyle.alert)
                
                
                refreshAlert.addAction(UIAlertAction(title: " OK ", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                    print("OK , FUE SELECCIONADO")
                    
                    return
                    
                }))
            
                present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        if nombreDeViaje.text != ultimoviaje2 {
            //            print ("nombre del viaje del arituclo es: \(nombreDeViaje.text) y ultimo viaje es \(ultimoviaje) HAY QUE ACUTUALIZAR")
            cambiarviaje()
            print("HAY QUE ACTUALISAR")
        } else {
            
            print("NO HAY QUE ACTUALISAR NADA")
        }
       

    ///////////
            do {
                let searchResultsDetalle = try DatabaseController.getContext().fetch(fetchRequestDet)
        
                //  print("Result of VIAJES: \(searchResultsViaje.count
        
                for resultv in searchResultsDetalle as [Detalle] { //LOOP
        
                    if resultv.numeroDePedido > 0 {
                        print("SECUENCIA \(secPedido)  and COREDATA SEC: \(resultv.numeroDePedido) ")
                        
                        if Int32(secPedido) == resultv.numeroDePedido {
                            
                            print("sec: \(secPedido)")
        
        
        
        
        
                            // buscar cuantas referecnias perteneciente a este PEDIDO
        
                            //                       Add Predicate Working PErfect
                            let predicate = NSPredicate(format: "ANY det.numeroDePedido == %@", "\(resultv.numeroDePedido)")
                            fetchRequestRef.predicate = predicate
                           
                            
                            do {
                                let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
                                print("Cantidad de Referencia en \(resultv.numeroDePedido) es: \(searchResultRef.count)" )
                                
                                for result in searchResultRef as [Referencia] {
      
                                    if result.referencia == SecRefLabel.text { // CHEKIAR SI LA REFERECIA EXISTE EN EL PEDIDO
                                       
                                        
                                   
                                        alertnow(numper: resultv.numeroDePedido)
                                       return

        
                                    }
                                }
        
                            }catch {
                                print("ERROR")
        
                            }
        
                           
                            
                            
                            
        
                        }
        
                    }
        
                }
        
        
            } catch{
                print("Error: \(error)")
        
            }
        
        
        
        
        print("AKI SI PASA EL CODIGO") // la referencia no existe en el pedido vamos aproceder
        
//        if fromDetPedCrear == true {
//            secPedido = exitePedido
//            exitePedido = ""
//        }
        
            if exitePedido == "" {
                //                            print("LO SALVO AL PEDIDO == \(exitePedido)   <==")
                  fetchRequestRef.predicate = nil
                
                do {
                    let searchResults4 = try DatabaseController.getContext().fetch(fetchRequestRef)
        
                    for resu in searchResults4 as [Referencia] {
//                        print("HASTA AKI ESTA LLEGANDO \(resu.referencia) REF EN PROGRAMA \(SecRefLabel.text) ")
                       
                        if resu.referencia == SecRefLabel.text {

                           
                            if !fromDetPedCrear && !customPedido {
//                                        print("EXISTE REFERENCIA \(resu.referencia)COMPARAR CON :\(SecRefLabel.text) en PEDIDO \(secPedido) ")
                                
                                        let nomDetalle: String = String(describing: Detalle.self)
                                        let det:Detalle = NSEntityDescription.insertNewObject(forEntityName: nomDetalle , into: DatabaseController.getContext()) as! Detalle
                                        
                                       if det.numeroDePedido != Int32(secPedido) {
                                        print("det numeropedido: \(det.numeroDePedido)  secuencia: \(secPedido)")
                                        
                                        let a = secPedido
                                        print("PENDIENTE A PEDIDO " + a)
                                        let b = cantidadEnCaja.text! //    print("cantidad en caja \(b)")
                                        let c = cajas.text!
                                        let d = ppv.text!
                                        
                                        det.numeroDePedido = Int32(a)!
                                        det.cantidadTotal = Int32(b)!
                                        det.cantidaDecajas = Int32(c)!
                                        det.precioDeVenta = Double(d)!
                                    
                                        
                                        det.timestamp = Date()
                                        
                                        det.addToRef(resu)
                                        
                                        DatabaseController.saveContext()
                                        
                                        }
                               
                                if agregarAlpedidoDirecto != true {
                                    
                                    if let presenter = self.presentingViewController as? Menua {
                                        presenter.set = 1
                                        
                                    }
                               
                            dismiss(animated: true, completion: nil)
                                    
//                                            self.performSegue(withIdentifier: "Registrar2Menu", sender: nil)
                                
                             }
                                
                            } else if fromDetPedCrear == true || customPedido == true  {  //fromDetPedCrear TRUE and customPedido = true
                                print("ES FROM PED TRUE")
      
                                do {
                                    let searchresult = try DatabaseController.getContext().fetch(fetchRequestDet)
                                    for result in searchresult as [Detalle] {
                                        if result.numeroDePedido == Int32(secPedido) {
                                            print("resultpedido \(result.numeroDePedido) sec: \(secPedido) ")
                                            let a = secPedido
                                            print("PENDIENTE A PEDIDO " + a)
                                            let b = cantidadEnCaja.text! //    print("cantidad en caja \(b)")
                                            let c = cajas.text!
                                            let d = ppv.text!
                                            let e = totalCbmLabel.text!
                                            
                                            result.numeroDePedido = Int32(a)!
                                            result.cantidadTotal = Int32(b)!
                                            result.cantidaDecajas = Int32(c)!
                                            result.precioDeVenta = Double(d)!
                                            
                                            if factoriabool == false {
                                                // found a nil while unwraping e
                                                
                                            result.totalcbm = Double(e)!
                                                
                                                
                                            }
                                            
                                            result.addToRef(resu)
                                            
                                            DatabaseController.saveContext()
                                           
                                        }

                                        
                                        
                                        
                                        
                                        if customPedido == true {
                                            if let presenter = self.presentingViewController as? Menua {
                                                presenter.set = 1
                                                
                                            }
                                            dismiss(animated: true, completion: nil)
                                            
                                            
//                                            self.performSegue(withIdentifier: "Registrar2Menu", sender: nil)
                                       
                                        
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                } catch {
                                    print("error")
                                }
                                
                                
                                
                            } // end TRUE
                            
                            
                        } // end referencia are equals
                    
                    
                    
                    
                    }
                    
                    
                } catch {
        
                }
        
        
        
            }
        
        
        
        //////////
        
     
    }
    
  
    
   func MismoSuplidorSalvar() {
   
    if cantidadEnCaja.text != "" && descripcion.text != "" && cajas.text != "" && precio.text != "" && suplidorLabel.text != "" && tipoDeMercanciaSegment.selectedSegmentIndex >= 0 && calle.text != "" {
        userD.set(0, forKey: "indexpath")
        userD.synchronize()
            var valor: Int64 = 0
            
            if existe == false {
                
                if noSequence == true {
                    SecRefLabel.text = EntradaReferencia.text
                    
                }
                
                
                print(" NO EXISTE")
//                blurscreen.isHidden = false
                do {
                    
                    let searchresult5 = try DatabaseController.getContext().fetch(fetchRequestCon)
                    
                    
                    for result5 in searchresult5 as [Configuracion] {
                        
                       
                        if result5.tipo == "principal" {
                            if noSequence == false {
                            result5.refSecNum = secrefnum + 1
                            DatabaseController.saveContext()
                            
                        }
                       
                        }
                        
                        
                        
                    }
                    
                } catch{
                    
                } // closed
                
                do {
                    let searchResults4 = try DatabaseController.getContext().fetch(fetchRequestVia)
                    
                    for resu in searchResults4 as [Viaje] {
                        
                        if resu.nombreDelViaje == nombreDeViaje.text {

                            let NumeroDeReferencia:String = String(describing: Referencia.self)
                            
                            let ref:Referencia = NSEntityDescription.insertNewObject(forEntityName: NumeroDeReferencia, into: DatabaseController.getContext()) as! Referencia
                            ref.referencia = SecRefLabel.text
                            ref.descripcion = descripcion.text
                            
                            if noSequence == true {
                                
                                
                                
                                if cdbTextField.text != "" {
                                    
                                    valor = Int64(cdbTextField.text!)!
                                    
                                }
                                
                                
                                ref.codigoDeBarra = valor
                                
                            }
                            
                            
                            if cmTextfield.text != "" {
                                ref.tamanoencm = Double(cmTextfield.text!)!
                            }
                            
                            
                            if libras.text != "" {
                                
                            ref.libras = Double(libras.text!)!
                            }
                            ref.cantidadEnCaja = Int32(cantidadEnCaja.text!)!
                            
                            ref.caja = Int32(cajas.text!)!
                            
                            if swichPrecios.isOn {
                             ref.precioUsd = Double(precioUSD.text!)!
                                ref.precioRmb = 0.0
                            } else {
                            
                            ref.precioRmb = Double(precio.text!)!
                                ref.precioUsd = 0.0
                            }
                          ////////////////////////////////
                            if imagenDeTargeta != nil {
                                targeta = true
                            }
                            
                            if foto != nil {
                                haveFoto = true
                            } else {
                                haveFoto = false
                            }

                            if haveFoto == true {
                                
                                ref.fotoReferencia = fotoReferencia
                                ref.nombreDeFoto1 = nomfoto1
                                
                            }
                            if targeta == true {
                             ref.nombreDeFotoTargeta = nomfototar
                            }
                           ////////////////////////////////
                            
                            ref.ppv = Double(ppv.text!)!
                            
                            if cbm != "" {
                                let sttd = Double(cbm)
                            
                            let stt = String(format: "%.3f", arguments: [sttd!])    // var has to be an double to rearrange decimals
                            
                            ref.cbm = Double(stt)!
                            } else {
                                ref.cbm = 0.000
                            }
                            
//                            var cblabel = String()
//                            if let pv = totalCbmLabel.text {
//                                cblabel = pv //totalCbmLabel.text!
//                            }
                            if factoriabool == true {
                                ref.fabrica = true
                            } else {
                                ref.fabrica = false
                            }
                            
                            if totalCbmLabel.text != "" {
                                ref.cbmtotal = Double(totalCbmLabel.text!)!
                            } else {
                                ref.cbmtotal = 0.000
                            }
                            
                            
                            ref.suplidor = suplidorLabel.text
                            ref.savedRefLet = reflet
                            ref.savedRefNum = secrefnum
                            
                            var num = 1
                            
                            
                            for i in totalcolors {
                                
                                
                                
                                
                                if totalcolors.count == num {
                                    coloresString.append(i)
                                    
                                } else {
                                    coloresString.append(i + ",")
                                }
                                
                                num += 1
                            }
                            print("\(coloresString)")
                            
                            if coloresString != "" {
                                ref.colores = coloresString
                            }
                            
                            
                            
                            
                           
                            if SwitchSelectivo.isOn {
                                ref.llevaSelectivo = true
                            } else {
                                 ref.llevaSelectivo = false
                            }
                            
                            if calle.text != "" {
                                ref.calle = calle.text
                            }
                            
                            if switchEmpaque.isOn {
                                ref.empaqueConMadera = "SI"
                            }
                            if !switchEmpaque.isOn {
                                ref.empaqueConMadera = " "
                            }
                            
                            if switchEmpaqueSeparado.isOn {
                                ref.formaDeEmpaque = "SI"
                            }
                            if !switchEmpaqueSeparado.isOn {
                                ref.formaDeEmpaque = " "
                            }
                            
                            if switchCategoria.isOn && categoriaField.text != "" {
                                ref.porcientoAdicional = Double(categoriaField.text!)!
                                ref.llevaPocientoAdicional = true
                            } else {
                                ref.porcientoAdicional = Double()
                                ref.llevaPocientoAdicional = false
                            }
                            
                            
                            if switchConfirmar.isOn && confirmarField.text != "" {
                                ref.observacion = confirmarField.text
                                ref.confirmacion = true
                            } else {
                                ref.observacion = ""
                                ref.confirmacion = false
                            }
                            
                            
                            ref.categoria = tipoMercancia

                            // MARK: - Create the relatioship between referecnia and viaje
                            ref.via = resu
                            
                
                            DatabaseController.saveContext()

                        }
                        
                        
                    }
                    
                } catch {
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    
//                    self.blurscreen.isHidden = true
                   
                    //  self.functioToCall()
                })
               
                if agregarAlpedidoDirecto == true {
                    
                    agregarApedido(self)
                }
                
                cantidadEnCaja.text = ""
                descripcion.text = ""
                cajas.text = ""
                precio.text = ""
                precioUSD.text = ""
                
                
                if switchCategoria.isOn {
                    
                    
                } else {
                    categoriaField.text = ""
                     switchCategoria.setOn(false, animated: true)
                    
                }
                
                
               
                
                confirmarField.text = ""
                libras.text = ""
                totalRmb.text = ""
                totalUsd.text = ""
                cantidadTotal.text = ""
                foto.image = nil
                totalcolors = []
                coloresString = ""
                cbmField.text = ""
                totalCbmLabel.text = ""
                labelFoto.text = ""
                nomfoto1 = ""
                if fromMenuaCustome == true {
                 cdbTextField.text = ""
                    EntradaReferencia.text = ""
                }
                
                
                blanco.setImage(UIImage(named: "blanco.png"), for: .normal)
                black.setImage(UIImage(named: "negro.png"), for: .normal)
                marron.setImage(UIImage(named: "marron.png"), for: .normal)
                azul.setImage(UIImage(named: "azul.png"), for: .normal)
                gris.setImage(UIImage(named: "gris.png"), for: .normal)
                mamey.setImage(UIImage(named: "mamey.png"), for: .normal)
                amarillo.setImage(UIImage(named: "amarillo.png"), for: .normal)
                rojo.setImage(UIImage(named: "rojo.png"), for: .normal)
                rosado.setImage(UIImage(named: "rosado.png"), for: .normal)
                verde.setImage(UIImage(named: "verde.png"), for: .normal)
                azulcielo.setImage(UIImage(named: "azulcielo.png"), for: .normal)
                morado.setImage(UIImage(named: "morado.png"), for: .normal)
                crema.setImage(UIImage(named: "crema.png"), for: .normal)
                if factoriabool ==  true {
                factoriabool = true
                } else {
                    factoriabool = false
                }
                

                 continuar = true
                
                
                // Switchs
                // switchColores
                
                SwitchSelectivo.setOn(false, animated: true)
                switchEmpaque.setOn(false, animated: true)
                switchEmpaqueSeparado.setOn(false, animated: true)
                
              
                

               
                
                
                switchConfirmar.setOn(false, animated: true)
                if continuar != true {
                tipoDeMercanciaSegment.selectedSegmentIndex = -1
                }
                
                    // AGREGAR VISTA NUBLADA CON MENSAJE for unos segundo
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                    self.blurscreen.isHidden = true
//                    self.SecRefLabel.text = String("\(self.reflet)-\(self.secrefnum)")
                    
                })
                
                
                
                print("\(agregarAlpedidoDirecto)")

//                continuar = true
               
                
                 descripcion.becomeFirstResponder()
                
                viewDidLoad()
               
    
                

                
                
                
                
                
                
                
                
                
                
                
                
                
            }
            
    } // end if buton
//     self.repetir = true
} // END BUTTON
    
   

    
    
    
       
   
    
    @IBAction func buttonsaving(_ sender: UIButton) {
        if totalCbmLabel.text == "" {
            print("DEVE DIGITAR CBM")
            return
        }
        
//        if foto.image == nil {
//            return
//        }
        
        
        print("ENTRA1 : \(factoriabool)")
        
        if factoriabool == false && calle.text == "" {
            nopaso = true
            sender.shake()
             print("ENTRA 2 \(factoriabool)")
            
        } else if factoriabool == true && calle.text == ""   {
            nopaso = false
           print("ENTRA 3 \(factoriabool)")
            
        } else {
            
            print("entra 4")
            nopaso = false
        }
        
        
        
        

        if noSequence != true || fromMenuaCustome == true {
//            if foto == nil {
//                return
//            }
            print ("ENTRO AKI PRIMERO")
            
            if cantidadEnCaja.text != "" && descripcion.text != "" && cajas.text != "" && precio.text != "" && suplidorLabel.text != "" && tipoDeMercanciaSegment.selectedSegmentIndex >= 0 && nomfoto1 != "" && foto != nil && nopaso == false {
            
            
            
            

            print ("ENTRO AKI SEgundo")
             sender.pulsate()
//
            if existe == false {
                    let refreshAlert = UIAlertController(title: "OPCIONE DE SALVAR", message: """
                                                                                     Deseas Salvar Y Seguir
                                                                                     con el mismo Supidor.
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
                        self.salvarNuevoSuplidor(self)
                        print("NO, FUE SELECCIONADO")
                        
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: "SI", style: .cancel, handler: { (action: UIAlertAction!) in
                        self.MismoSuplidorSalvar()
                        print("SI, FUE SELECIONADO")
                    }))
                if fromMenuaCustome != true {
                refreshAlert.addAction(UIAlertAction(title: "SI y Agregar a Pedido", style: .default, handler: { (action: UIAlertAction!) in
                    self.agregarAlpedidoDirecto = true
                    self.secPedido = self.transferPedido
                    self.MismoSuplidorSalvar()
                    
                  
                    print("SI, agregar a pedido")
//                    DispatchQueue.global(qos: .background).async {
//                        // Background Thread
//                        DispatchQueue.main.async {
//                            // Run UI Updates or call completion block
//                           self.agregarAlpedidoDirecto = true
//
//                        }
//                    }
                   
                    
                }))
            } // frommenuacustom end if
                
                
                    present(refreshAlert, animated: true, completion: nil)
            } else {
                
                self.salvarNuevoSuplidor(self)
                
            }
        }
        } else {
            
             self.salvarNuevoSuplidor(self)
        } // END IF FROMDETPEDCREAR
        
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print("IMAGE TAPPED")
       
        
        
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds //CGRect(x: 0, y: 150, width: 800, height: 800) //
       

         let pangesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        newImageView.addGestureRecognizer(pangesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
//        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotation))
        newImageView.addGestureRecognizer(pinchGesture)
//        newImageView.addGestureRecognizer(rotationGesture)
  
        newImageView.backgroundColor = .white
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
       
        newImageView.addGestureRecognizer(tap)

        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    
    
//    @objc func rotation(gesture: UIRotationGestureRecognizer) {
//        print("rotation")
//    }
    
    @objc func actionPinchGesture(recognizer: UIPinchGestureRecognizer) {
        
        
                print("ZOOMING")
        
        let avg = recognizer.view!.frame.height
        print(UIScreen.main.bounds.height)
        print(avg)

        if let view = recognizer.view {
        
            
            if (avg >= UIScreen.main.bounds.height && recognizer.scale >= 1) || (avg > UIScreen.main.bounds.height  && recognizer.scale <= 1) {
               
                
                
                print(UIScreen.main.bounds.height)
                print(avg)
                
                
            
                
                view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
                
                
                
                
                print(recognizer.scale)
                
                
                recognizer.scale = 1
                
            } else {
                view.transform = CGAffineTransform.identity
                
                
            }
            
        }
        
        
        
        
    }
    
    
    @objc func onClickImageView(recogizer: UIPanGestureRecognizer) {
        let translation = recogizer.translation(in: self.view)
        if let view = recogizer.view {
            var centro = recogizer.view?.center
            
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        
        recogizer.setTranslation(CGPoint.zero, in: self.view)
       
    }

    
    
    
    
    @IBAction func salvarNuevoSuplidor(_ sender: Any) {
        userD.set(0, forKey: "indexpath")
        userD.synchronize()
        nopaso = Bool()
       var valor:Int64 = 0
        
//        var didmac = Bool()
        
        
        if cantidadEnCaja.text != "" && descripcion.text != "" && cajas.text != "" && precio.text != "" && suplidorLabel.text != "" && tipoDeMercanciaSegment.selectedSegmentIndex >= 0 && nopaso == false {
            
            
           if existe == false {
            
            if noSequence == true {
                 SecRefLabel.text = EntradaReferencia.text
          
            }
            
        print(" NO EXISTE")

            
           
        do {
       
            let searchresult5 = try DatabaseController.getContext().fetch(fetchRequestCon)
         
            
            for result5 in searchresult5 as [Configuracion] {
              
                
                    if result5.tipo == "principal" {
                        
                        if noSequence == false {
                            
                        result5.refSecNum = secrefnum + 1
                        DatabaseController.saveContext()
                            print("Sumando REFERENCIA")
                            
                        }
                        
                        
                    
                        }
                    
                
                
                
               
                
                
                
            }
            
            
            
            
            
           
            
            
            
        } catch{
            
        } // closed
            
           
            
       
         do {
              let searchResults4 = try DatabaseController.getContext().fetch(fetchRequestVia)
        
               for resu in searchResults4 as [Viaje] {
        
                   if resu.nombreDelViaje == nombreDeViaje.text {
                    
                    
                            let NumeroDeReferencia:String = String(describing: Referencia.self)
        
                            let ref:Referencia = NSEntityDescription.insertNewObject(forEntityName: NumeroDeReferencia, into: DatabaseController.getContext()) as! Referencia
                                    ref.referencia = SecRefLabel.text
                                    ref.descripcion = descripcion.text
                    
                                    ref.cantidadEnCaja = Int32(cantidadEnCaja.text!)!
                 
                    if libras.text != "" {
                        
                        ref.libras = Double(libras.text!)!
                    }
                    ref.caja = Int32(cajas.text!)!
                    
                    if noSequence == true {
                        
                        
                        
                       if cdbTextField.text != "" {
                        
                        valor = Int64(cdbTextField.text!)!
                        
                        }
                        
                        
                       ref.codigoDeBarra = valor
                        
                    }
                    
                    
                    
                   
                    
                    
                    if swichPrecios.isOn {
                        ref.precioUsd = Double(precioUSD.text!)!
                        ref.precioRmb = 0.0

                    } else {
                        ref.precioUsd = 0.0
                        
                        ref.precioRmb = Double(precio.text!)!
                    }
                    
                    
                    
                    ref.ppv = Double(ppv.text!)!
                    
                    if imagenDeTargeta != nil {
                        targeta = true
                    }
            
                    
                    if foto != nil {
                        haveFoto = true
                    } else {
                        haveFoto = false
                    }
                    
                    
                    if haveFoto == true {
                    ref.fotoReferencia = fotoReferencia
                    ref.nombreDeFoto1 = nomfoto1
                       
                    }
                        
                    if targeta == true {
                        
                        ref.nombreDeFotoTargeta = nomfototar
                    }
                   
                   
                    
                    if cbm != "" {
                        let sttd = Double(cbm)
                    
                    let stt = String(format: "%.3f", arguments: [sttd!])    // var has to be an double to rearrange decimals
                    
                    ref.cbm = Double(stt)!
                    } else {
                         ref.cbm = 0.000
                    }
                    
                    if cmTextfield.text != "" {
                          ref.tamanoencm = Double(cmTextfield.text!)!
                    }
                   
                    
                     if targeta == true {
                     ref.nombreDeFotoTargeta = nomfototar
                    }
                    if calle.text != "" {
                    ref.calle = calle.text
                    }
                    if factoriabool == true {
                        ref.fabrica = true
                    } else {
                        ref.fabrica = false
                    }
                    
                    ref.suplidor = suplidorLabel.text
                    ref.savedRefLet = reflet
                    ref.savedRefNum = secrefnum
                    
                    ////////////////
                    
                    if totalCbmLabel.text != "" {
                        ref.cbmtotal = Double(totalCbmLabel.text!)!
                    } else {
                        ref.cbmtotal = 0.000
                    }
                    
                    var num = 1
                  
                    
                    for i in totalcolors {
                        
                        
                        
                        
                        if totalcolors.count == num {
                            coloresString.append(i)
                            
                        } else {
                            coloresString.append(i + ",")
                        }
                        
                        num += 1
                    }
                    
                    
                    print("\(coloresString)")
                    
                    if coloresString != "" {
                        ref.colores = coloresString
                    } else {
                        ref.colores = "UN SOLO COLOR"
                    }
                    
                    /////////////////////////
                  
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    if SwitchSelectivo.isOn {
                        ref.llevaSelectivo = true
                    } else {
                        ref.llevaSelectivo = false
                    }
                    
                    
                    if switchEmpaque.isOn {
                        ref.empaqueConMadera = "SI"
                    }
                    if !switchEmpaque.isOn {
                        ref.empaqueConMadera = " "
                    }
                    
                    if switchEmpaqueSeparado.isOn {
                        ref.formaDeEmpaque = "SI"
                    }
                    if !switchEmpaqueSeparado.isOn {
                        ref.formaDeEmpaque = " "
                    }
                    
                    if switchCategoria.isOn && categoriaField.text != "" {
                        ref.porcientoAdicional = Double(categoriaField.text!)!
                        ref.llevaPocientoAdicional = true
                    } else {
                        ref.porcientoAdicional = Double()
                        ref.llevaPocientoAdicional = false
                    }
                    
                    
                    if switchConfirmar.isOn && confirmarField.text != "" {
                        ref.observacion = confirmarField.text
                        ref.confirmacion = true
                    } else {
                        ref.observacion = ""
                        ref.confirmacion = false
                    }
                    
                    
                    ref.categoria = tipoMercancia

                    
                    
                    
                    
                    
                    
                            // MARK: - Create the relatioship between referecnia and viaje
                            ref.via = resu
        
                                      DatabaseController.saveContext()
        
        
                    
                            
                        }
                        
                        
                        
                    }
                    
                } catch {
                    
                } // closed

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                

                
                
                if self.fromDetPedCrear == false {
                    if let presenter = self.presentingViewController as? Menua {
                        presenter.pathToLastRow = IndexPath.init(row: 0, section: 0)
                        presenter.set = 1
                        presenter.wasnewsaved = true
                        presenter.comingback2M = true
                        
         
                        
                    }
                   self.dismiss(animated: true, completion: nil)
                    
//                   self.performSegue(withIdentifier: "Registrar2Menu", sender: nil)
                } else {
                    
                    if let presenter = self.presentingViewController as? DetallePedido, self.fromPedido, !self.fromDetPedCrear {
                        presenter.secPedido = self.secPedido
                        presenter.myDict = [String:String]()
                        presenter.myArray = [[String:String]]()
                        presenter.commingback = true
                    }

                    if let presenter = self.presentingViewController as? DetallePedido, self.fromDetPedCrear {
                        presenter.secPedido = self.secPedido
                        presenter.myDict = [String:String]()
                        presenter.myArray = [[String:String]]()
                        presenter.commingback = true
                        self.agregarApedido(self)
                    }

//                    if let presenter = self.presentingViewController as? Menua {
//                        presenter.set = 1
//
//                    }

                    self.dismiss(animated: true, completion: nil)
                    
                    
//                    self.performSegue(withIdentifier: "registrar2Pedido", sender: nil)
                }
               //   chekiar si afecta
                
                if self.fromMenuaCustome == false {
                     self.dismiss(animated: true, completion: nil)
//                    self.performSegue(withIdentifier: "Registrar2Menu", sender: nil)
                } else {
                     self.dismiss(animated: true, completion: nil)
//                    self.performSegue(withIdentifier: "Registrar2Menu", sender: nil)

                }
                
                
                
                
                //  self.functioToCall()
                })
         
            
            
/////////////////////

    
        } else {   // SI EXISTE VAMOS SALVAR
        
       print(" SI EXISTE VAMOS SALVAR" )  // ESTO ES PARA EL PRODUCTO QUE YA EXISTE
   
          
        
   
//            blurscreen.isHidden = false
            
            ///////
            
            do {
                let searchResults4 = try DatabaseController.getContext().fetch(fetchRequestVia)
                
                for resu in searchResults4 as [Viaje] {
                    
                    if resu.nombreDelViaje == nombreDeViaje.text {

            
            
            
            
            ////////
            do {
                
            let searchResult = try DatabaseController.getContext().fetch(fetchRequestRef)
                
                for result in searchResult as [Referencia] {
                    
            
                    if result.referencia == oldReferencia { //     SecRefLabel.text {
            
                        
                        
                        result.referencia = SecRefLabel.text
                        result.descripcion = descripcion.text
                        
                        result.cantidadEnCaja = Int32(cantidadEnCaja.text!)!
                        
                        result.caja = Int32(cajas.text!)!
                        
                        if libras.text != "" {
                            
                           result.libras = Double(libras.text!)!
                        }
                        if imagenDeTargeta != nil {
                            targeta = true
                        }
                        if foto != nil {
                            haveFoto = true
                        }
                     
                        if haveFoto == true {
                            
                          
                            result.nombreDeFoto1 = nomfoto1
                            
                        }
                        if targeta == true {
                            result.nombreDeFotoTargeta = nomfototar
                        }
                       
                        if cmTextfield.text != "" {
                            result.tamanoencm = Double(cmTextfield.text!)!
                        }
                        
                        if cbm != "" {
                            
                        let sttd = Double(cbm)
                        
                        let stt = String(format: "%.3f", arguments: [sttd!])    // var has to be an double to rearrange decimals
                        
                        result.cbm = Double(stt)!
                        } else {
                            
                            result.cbm = 0.000
                        }
                        
                        if factoriabool == true {
                            result.fabrica = true
                        } else {
                            result.fabrica = false
                        }
                        if totalCbmLabel.text != "" {
                            result.cbmtotal = Double(totalCbmLabel.text!)!
                        } else {
                            result.cbmtotal = 0.000
                        }
                        
                        
                        
                        if swichPrecios.isOn {
                            result.precioUsd = Double(precioUSD.text!)!
                            result.precioRmb = 0.0

                        } else {
                            result.precioUsd = 0.0

                            result.precioRmb = Double(precio.text!)!
                        }

                        if calle.text != "" {
                            result.calle = calle.text
                        }
                        
                        
                         result.ppv = Double(ppv.text!)!
                        result.suplidor = suplidorLabel.text
                        result.savedRefLet = reflet
                        result.savedRefNum = secrefnum
                        
                        var num = 1
                        
                        
                        for i in totalcolors {
                            
                            
                            
                            
                            if totalcolors.count == num {
                                coloresString.append(i)
                                
                            } else {
                                coloresString.append(i + ",")
                            }
                            
                            num += 1
                        }
                        print("\(coloresString)")
                        
                        if coloresString != "" {
                            result.colores = coloresString
                        }
                        
                        
                        
                        
                       
                        
                        
                        
                        
                        
                        
                        
                        
                        if SwitchSelectivo.isOn {
                            result.llevaSelectivo = true
                        } else {
                             result.llevaSelectivo = false
                        }
                        
                        if switchEmpaque.isOn {
                            result.empaqueConMadera = "SI"
                        }
                        if !switchEmpaque.isOn {
                            result.empaqueConMadera = " "
                        }
                        
                        if switchEmpaqueSeparado.isOn {
                            result.formaDeEmpaque = "SI"
                        }
                        if !switchEmpaqueSeparado.isOn {
                            result.formaDeEmpaque = " "
                        }
                        
                        if switchCategoria.isOn && categoriaField.text != "" {
                            result.porcientoAdicional = Double(categoriaField.text!)!
                            result.llevaPocientoAdicional = true
                        } else {
                            result.porcientoAdicional = Double()
                            result.llevaPocientoAdicional = false
                        }
                        
                        
                        if switchConfirmar.isOn && confirmarField.text != "" {
                            result.observacion = confirmarField.text
                            result.confirmacion = true
                        } else {
                            result.observacion = ""
                            result.confirmacion = false
                        }
                        
                        result.via = resu
                        print("esto es lo que esta salvando cuando esta creado ====>\(tipoMercancia)  <====")
                        result.categoria = tipoMercancia
                    
                        DatabaseController.saveContext()
                        
                        // SHOUL I PUT A DISMISS HERE???
                        
                    }
                }
                
            } catch {
                
                print("error")
            }
        
                    }
                }
            } catch {
                
            }
            
            ////////// from pedido if historico is true
            if fromPedido == true && havehistorico == true {
                
                do {
                    let searchresult = try DatabaseController.getContext().fetch(fetchRequestHis)
                    
                    for resu in searchresult as [Pedidohistorico] {
                        print(" cantidad de enbtradas en historico BD \(searchresult.count)")
                        
                        if Int32(exitePedido)! == Int32(resu.numerodepedido!)! &&  SecRefLabel.text == resu.referencia! {
                            
                            resu.cantidadtotal = cantidadTotal.text
                            resu.cajas = cajas.text
                            resu.cantidadencaja = cantidadEnCaja.text
                           
                            if !swichPrecios.isOn {
                            
                            resu.moneda = "RMB $ "
                                
                             resu.precio = precio.text
                            
                            } else {
                                resu.moneda = "USD $ "
                              resu.precio = precioUSD.text
                      
                            }
                            
                            DatabaseController.saveContext()
                            
                        }
                    }
                } catch {
                    print("ERROR")
                    
                }
                        
            }
                        
                        
                        
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            

                
                if let presenter = self.presentingViewController as? DetallePedido, self.fromPedido, !self.fromDetPedCrear {
                     presenter.set = 1
                    presenter.secPedido = self.secPedido
                    presenter.commingback = true
                    
            }

                if let presenter = self.presentingViewController as? DetallePedido, self.fromDetPedCrear {
                     presenter.set = 1
                    presenter.secPedido = self.secPedido
                    self.fromPedido = true
                    presenter.commingback = true
                    self.agregarApedido(self)
                }

                if let presenter = self.presentingViewController as? Menua {
                    presenter.set = 1
                    presenter.wasnewsaved = false
                    presenter.comingback2M = true

                }

                self.dismiss(animated: true, completion: nil)

                
                
                
                
                // SI EXISTE VAMOS ODVIAR ESTO ,SI FROM PEDIDO == TRUE
//                if self.fromPedido == true {
//                    self.performSegue(withIdentifier: "registrar2Pedido", sender: nil)
//                } else if wasSearchInv == true {
//                   self.performSegue(withIdentifier: "registrar2Inventario", sender: nil)
//
//                } else if self.fromInv == true {
//                     self.performSegue(withIdentifier: "registrar2Inventario", sender: nil)
//                } else if self.fromConfirmar == true {
//
//                    self.performSegue(withIdentifier: "Registrar2Confirmar", sender: nil)
//
//                } else {
//                    self.performSegue(withIdentifier: "Registrar2Menu", sender: nil)
//                }
//
//
//            })
        
//        blurscreen.isHidden = true

    
    
            } //end if else existe
            
            
       
        }

        
        
     
        
        
        
        
    }
  
   
    
    ///////////
    func cambiarviaje() {
        do {
            let searchResults4 = try DatabaseController.getContext().fetch(fetchRequestVia)

            for resu in searchResults4 as [Viaje] {

                ///////////////////////arreglar

                if resu.nombreDelViaje == ultimoviaje2 {
                    do {
                        let searchResult = try DatabaseController.getContext().fetch(fetchRequestRef)

                        for result in searchResult as [Referencia] {


                            if result.referencia == oldReferencia {
                                // MARK: - Create the relatioship between referecnia and viaje
                                result.via = resu
                                DatabaseController.saveContext()
                            }

                        }


                    } catch {
                        print ("Error1")
                    }
                }
            }

        } catch {
            print ("error2")
        }

    } // end func
    
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//          print("THIS IS THE TAG \(textField.tag)")
//       switch textField.tag {
//
//
//        case 1:
//            moveTextField(categoriaField, moveDistance: -525, up: true)
//
//
//        case 2:
//
//            moveTextField(cantidadEnCaja, moveDistance: -525, up: true)
//
//        case 3:
//
//            moveTextField(cajas, moveDistance: -525, up: true)
//
//        case 4:
//
//            moveTextField(precio, moveDistance: -525, up: true)
//
//        case 5:
//
//           moveTextField(precioUSD, moveDistance: -525, up: true)
//       case 6:
//
//        moveTextField(cbmField, moveDistance: -525, up: true)
//
//       case 7:
//
//        moveTextField(confirmarField, moveDistance: -525, up: true)
//
//        default: break
//
//
//        }
//
//    }
//
   
    
    
  
    
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//       switch textField.tag {
//        case 1:
//             moveTextField(categoriaField, moveDistance: -525, up: false)
//
//
//        case 2:
//
//            moveTextField(cantidadEnCaja, moveDistance: -525, up: false)
//
//        case 3:
//
//            moveTextField(cajas, moveDistance: -525, up: false)
//
//        case 4:
//
//            moveTextField(precio, moveDistance: -525, up: false)
//
//        case 5:
//
//            moveTextField(precioUSD, moveDistance: -525, up: false)
//
//       case 6:
//        if cbmField.text == "" {
//            cbm = ""
//        }
//        moveTextField(cbmField, moveDistance: -525, up: false)
//
//       case 7:
//
//        moveTextField(confirmarField, moveDistance: -525, up: false)
//
//       default: break
//
//        }
//
//
//    }
//
    
  
    
 
   
        
    
  
    
  
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
   
    
  
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    
//    @IBAction func export2Album(_ sender: Any) {
//        /////
// 
//       
////
//        
//        
//        
////
//////         CustomPhotoAlbum().save(image: foto.image!)
////        let newImage = foto.image
////
////
////        let date :NSDate = NSDate()
////
////        let dateFormatter = DateFormatter()
////        //dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
////        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH_mm_ss"
////
////        dateFormatter.timeZone = NSTimeZone(name: "GMT")! as TimeZone
////
////        let imageName = "/\(dateFormatter.string(from: date as Date)).jpg"
////        print(imageName)
////        //var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
////        //var documentsDirectoryPath = getDocumentsURL().relativePath
////        var documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.picturesDirectory , .userDomainMask, true)[0]
////        documentsDirectoryPath += imageName
////
////      var t = NSSearchPathForDirectoriesInDomains
////
////
////        print(documentsDirectoryPath)
////
////        let settingsData: NSData = UIImageJPEGRepresentation(newImage!, 1.0)! as NSData
////        settingsData.write(toFile: documentsDirectoryPath, atomically: true)
//////       /private/var/mobile/Media/DCIM/
////
////          //  [imageData writeToFile:@"/private/var/mobile/Media/DCIM/100APPLE/customImageFilename.jpg" atomically:NO];
////
////
////
////
////
//    }
//
    
   func getcbmtotal(_ supli2: String) -> Double {
        var nomvia1 = String()
        var totalAdd = Double()
        
        if let varViaje = userD.object(forKey: "viajeactual") as? String {
            
            nomvia1 = varViaje
        }
        let predicate = NSPredicate(format: "ANY via.nombreDelViaje == %@", "\(nomvia1)")
            fetchRequestRef.predicate = predicate
        do {
            let result = try DatabaseController.getContext().fetch(fetchRequestRef)
            for ref in result as [Referencia] {
                if ref.suplidor == supli2 {
                    
                    arrayCbmDouble.append(ref.cbmtotal)
                }
                
            }
            
            
            
        } catch {
            print("error")
        }
        
        for i in 0..<arrayCbmDouble.count {
            totalAdd += arrayCbmDouble[i]
            
        }
        
//
    fetchRequestRef.predicate = nil
        arrayCbmDouble = []
        return totalAdd
    }

   
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
//        if textField == self.suplidorLabel {
//            self.calle.becomeFirstResponder()
//        }
//
         calle.becomeFirstResponder()
        return true
       
        
    }
    
    
    
}

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIViewController {
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.nextField == nil) {
            textField.resignFirstResponder()
        } else {
            textField.nextField?.becomeFirstResponder()
        }
        return true
    }
}


