//
//  Menu.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/22/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData
import Photos
import MessageUI

public var fromMenua = Bool()
public var rmb = String()
public var rd = String()
public var wasSearch = false

protocol UpdateImage: class {
    func updateImageWith(asset:PHAsset,name:String)
}

class Menua: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, GetsImageFromAsset, MFMailComposeViewControllerDelegate, CustomCellDelegate, UpdateImage {
    func updateImageWith(asset: PHAsset, name: String) {
        images[name] = asset
    }
    
   
    
    
    var userD = UserDefaults.standard
    var controlResult = String()
    var tipo:[String] = ["LOCAL","FACTORIA","TODAS"]
    var conSeg = Int()
    var image = UIImage()
    var localBool = Bool()
    var arrayRef = [String]()
    var ind = Int()
    var tex = String()
    var transData = String()
    var tap = Bool()
    var idxw = 0
    var passReferencia = String()
    var pathToLastRow = IndexPath.init(row: 0, section: 0)
    var wasnewsaved = false
    var comingback2M = false
    var tieneInformacion = Bool()
    var fotoloader = [String]()
    var getLocalid = [String : String]()
    var nomfoto1 : String?
    weak var delegate: UpdateImage?
    var referencia = String()
    var locaLINDENT = String()
    
    
    
    
    
    
    private var selectedItems = [String]()
    

  //  var nomvia = String()
    
    @IBOutlet weak var tipoCompra: UISegmentedControl!
    @IBOutlet weak var viajelabel: UILabel!
       @IBOutlet weak var addbuttonOutlet: UIButton!
   
    @IBOutlet weak var labelEnviarCompra: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var labelRmb: UILabel!
    @IBOutlet weak var labelRD: UILabel!
   
    @IBOutlet weak var mercAgotadaBoton: UIButton!
    
              var set = 1
  
    
     fileprivate var imageItemArray = [ListaReferencia]()
    
//   var picArray = [UIImage(named:"Lamp")]
    
//    var picArray = [UIImage]()
    
    var fotos = [UIImage]()
    var images = [String: PHAsset]()

    //var nomvia = String()
    
    
    
    
    
    //MARK: - search bar related
        
    fileprivate func setUpSearchBar() {
        
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
        
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["REFERENCIA","DESCRIPCION","SUPLIDOR"]
        
       
      
        if wasSearch == true {
            if let tf = userD.object(forKey: "seleccion") as? Int {
                ind = tf
            }
            if let tf1 = userD.object(forKey: "searchtext") as? String {
                tex = tf1
            }
            searchBar.selectedScopeButtonIndex = ind
            searchBar.text = tex
        } else {
            
             searchBar.selectedScopeButtonIndex = 0
        }
        
       
        
        searchBar.delegate = self
        
     self.tableview.tableHeaderView = searchBar
        //self.tableview.addSubview(searchBar)
    
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let varViaje = userD.object(forKey: "nombreDelViaje") as? String {
            addbuttonOutlet.isHidden = false
            viajelabel.text = "COMPRA \(varViaje)"
            // nomvia = varViaje
                    let chck = userD.object(forKey: "ultimoViaje") as! Bool
            //  print("\(chck)", "AKI ES")
            if chck != true {
                addbuttonOutlet.isHidden = true
            }
            updateData() //  loading tableview every time it come from lista de viaje
            
        }
        
        
        if comingback2M {
            
            if let varViaje = userD.object(forKey: "nombreDelViaje") as? String {
                addbuttonOutlet.isHidden = false
                viajelabel.text = "COMPRA \(varViaje)"
                // nomvia = varViaje
            
                let chck = userD.object(forKey: "ultimoViaje") as! Bool
                //  print("\(chck)", "AKI ES")
                if chck != true {
                    addbuttonOutlet.isHidden = true
                }
                
            }
            
            
            
            
            
            
            
            
            getExchangeRate()
            updateData()
            tableview.reloadData()
        
            if wasnewsaved {
                set = 1
                wasnewsaved = false
                
                if tieneInformacion == true {
                   tableview.scrollToRow(at: pathToLastRow, at: .none, animated: true)
                }
                
            
            }
        
        } else {
            
            
            
            getExchangeRate()
            set = 1
            if let tempIPATH =  userD.object(forKey: "indexpath") {
                idxw = tempIPATH as! Int  //userD.object(forKey: "indexpath") as! Int
                pathToLastRow = IndexPath.init(row: idxw, section: 0)
                
                if idxw == 0 {
                    
                } else {
                     tableview.scrollToRow(at: pathToLastRow, at: .none, animated: true)
                }
               
                
            }
            
            //
           
        }
        
        
    }
    
        override func viewDidLoad() {
            
            loadImages()
            ////
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)

            for item in items {
                
                    fotoloader.append(item)
                    // this is a picture to load!
                
                
                
   
            }
            print("these are: \(fotoloader)")
         ///
            
            
            
            
            
            
            
            
            
            super.viewDidLoad()
//            var dtert = formatterDateTime()

            tableview.dataSource = self
            tableview.delegate = self
            
            getExchangeRate()
            
//
            
            
            // esto no se mueve
            let tut = false
            fromMenua = true
            userD.set(tut, forKey: "desde")
        
            userD.synchronize()
            
          if let sego = userD.object(forKey: "segmentmenu") as? Int {
            tipoCompra.selectedSegmentIndex = sego
          } else {
            tipoCompra.selectedSegmentIndex = 2
            }
            
            
            
            
            addbuttonOutlet.isHidden = true
            
            set = 1
            updateData()
            
            setUpSearchBar()
           
           if let varViaje = userD.object(forKey: "nombreDelViaje") as? String {
               addbuttonOutlet.isHidden = false
                        viajelabel.text = "COMPRA \(varViaje)"
               // nomvia = varViaje
                        
                        let chck = userD.object(forKey: "ultimoViaje") as! Bool
                   //  print("\(chck)", "AKI ES")
                        if chck != true {
                            addbuttonOutlet.isHidden = true
                        }
                        
            }
          
            
            
            if let tempIPATH =  userD.object(forKey: "indexpath") {
                idxw = tempIPATH as! Int //userD.object(forKey: "indexpath") as! Int
                pathToLastRow = IndexPath.init(row: idxw, section: 0)
                
              
                if idxw == 0 {
                    
                } else {
                    tableview.scrollToRow(at: pathToLastRow, at: .middle, animated: true)
                }
              
                
            }

//
           
            
//            userD.set(0, forKey: "indexpath")
//            userD.synchronize()
//            tableview.reloadData()
            
        }
    

   
    
    func updateData() {
        
        if wasSearch == true {
            if let tf = userD.object(forKey: "seleccion") as? Int {
            ind = tf
            }
            if let tf1 = userD.object(forKey: "searchtext") as? String {
                tex = tf1
            }
            
            
            imageItemArray = CoreDataManager.fetchObj(selectedScopeIdx: ind, targetText: tex)
         
        } else {
            
            imageItemArray = CoreDataManager.fetchObj()
        }
        imageItemArray = imageItemArray.reversed()
        print("Count: \(imageItemArray.count)")
        
        
        
//        let identifiers = imageItemArray.flatMap { $0.fotoReferencia }
//        let assets = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
//
//        var array = [FotoConReferencia]()
//        assets.enumerateObjects({ [weak self] (asset, int, pointer) in
//            let fotoConReferencia = FotoConReferencia(fotoReferencia: asset.localIdentifier, imagen: self?.getUIImage(asset: asset) ?? UIImage())
//            array.append(fotoConReferencia)
//        })
//
//        var newArray = [UIImage?](repeating: nil, count: imageItemArray.count)
//
//        for foto in array {
//            if let index = imageItemArray.index(where: { $0.fotoReferencia == foto.fotoReferencia}) {
//                newArray[index] = foto.imagen
//            }
//        }
//        fotos = newArray.flatMap { $0 }
        
        tableview.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            imageItemArray = CoreDataManager.fetchObj()
          
            
            tableview.reloadData()
            return
        }
        
        imageItemArray = CoreDataManager.fetchObj(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText:searchText)
        
        tableview.reloadData()
        print(searchText)
    }

   
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
   
      
        return "                       HAY \(imageItemArray.count) REFERENCIAS EN ESTA LISTA DE ESTE VIAJE"

    
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            
                return imageItemArray.count
        }
    
    
    func cellButtonTapped(data: Int) {
        let imgItem = imageItemArray[data]
        print("THIS ITEM NUMBER IS: \(imgItem.name)")
        Reftemp = "\(imgItem.name)"
        tap = true
//        var idx = userD.object(forKey: "indexpath") as? Int
//
//
//        let lastRowIndex = idx
//        let pathToLastRow = IndexPath.init(row: idx!, section: 0)
////        tableView.scrollToRow(at: pathToLastRow, at: .none, animated: false)
//        tableview.reloadData()
//        tableview.scrollToRow(at: pathToLastRow, at: .none, animated: true)
        
    }
   


        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           var hasHisto = Bool()
           
            let cell = self.tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
            cell.historico.isHidden = true
            let imgItem = imageItemArray[indexPath.row]
            
            if imageItemArray.isEmpty {
                tieneInformacion = false
            } else {
                tieneInformacion = true
            }
            
                cell.refer.text = imgItem.name
            
            do {
                
                let searchresult = try DatabaseController.getContext().fetch(fetchRequestHis)
                
                for result in searchresult as [Pedidohistorico] {
                    
//                   print("COUNT \(searchresult.count)")
                    
                   if imgItem.name == result.referencia {
                    cell.historico.isHidden = false
                   }
                    
                    
                    
                    
//                    print("REFERENCIA PEDIDA: \(result.referencia)")
                    
                    
//
//                    if let ref = result.referencia {
//                      checkRef = ref
//                    }
//                    if imgItem.name == "PG-14252" {
//
//
//                    }
//                    if result.referencia == nil {
//                        DatabaseController.getContext().delete(result)
//                        DatabaseController.saveContext()
//                    }
//
////               if checkRef != "" {
//
//                    if imgItem.name == result.referencia {
////                        print("REF TABLE: \(imgItem.name)")
////                        print("REF HISTO: \(checkRef)")
////
//                           cell.historico.isHidden = false
//
//                       } else if imgItem.name != result.referencia  {
//
//                           cell.historico.isHidden = true
//                        }
//
////                     }

                }
               
                
            } catch {
                print("Error")
            }
            

                cell.viewfortable.isHidden = true
                cell.descripcionLabel.text = imgItem.descripcion
                cell.historico.tag = indexPath.row
                cell.delegate = self
                cell.viewfortable.tag = indexPath.row
            let p1 = Double(imgItem.precio!)!
            let p2 = Double(imgItem.precioUsd!)!
            
            if p2 > 0 {
                cell.precio.text = "Costo Usd: \(p2)"
            } else {
                cell.precio.text = "Costo rmb: \(p1)"
                
            }
            
        
            
            cell.ppv.text = "Precio de venta: \(imgItem.ppv!)"
            
            cell.nombreFoto.text = "\(imgItem.nombrePic!)"
            
            
            
            
            ///   if has historico SHOW
            
            
            ////////////////
            

//            cell.historico.addTarget(self, action: #selector(buscarHistorico), for: .touchUpInside)
            

         
                if cell.imgRef != nil {
                    // fetch image using imgItem.fotoReferencia
                    let name = imgItem.nombrePic    //?.replacingOccurrences(of: "", with: "")
//
                   
                    
                    
                    
                    //////////////
                    if let fotoname = images[name!] {
                        cell.imgRef.image = getUIImage(asset: (images[name!]!))
                            
                    } else {
                        cell.imgRef.image = #imageLiteral(resourceName: "nophoto")
                    }
//                    cell.imgRef.image = getUIImage(asset: (images[name!] ?? images["nophoto.jpg"])!)
           
//                    if let varfoto1 = imgItem.fotoReferencia {
//                        //let options = PHFetchOptions.init()
//                        //options.fetchLimit = 1
//                        let asset = PHAsset.fetchAssets(withLocalIdentifiers: [varfoto1], options: nil)
//                        object.value(forKey: "IMG_3053.JPG")
//
//                        if asset.count > 0 {
//                            cell.imgRef.image = getUIImage(asset: asset[0])
//                        }
//                        //foto.image = UIImage(data:result8.foto1 as! Data,scale:1.0)
//
//                    }

                    //cell.imgRef.image = fotos[indexPath.row]
                }
                ////// GET LOCAL INDENTIFIER
           
//            if let image = cell.imgRef.image, let imageData = UIImageJPEGRepresentation(image, 0.3), let compressedJPGImage = UIImage(data: imageData) {
//
//                //TODO: only save image if it's picture being taken NEED TO FIX
//                PHPhotoLibrary.shared().savePhoto(image: compressedJPGImage, albumName: "Album", completion: { [weak self] (asset) in
//    //                print("123:# \(PHAssetResource.assetResources(for: asset!).first?.originalFilename)")
//                    self?.nomfoto1 = "\(PHAssetResource.assetResources(for: asset!).first!.originalFilename)"
//
//                    if let asset1 = asset,let name =  asset1.value(forKey: "filename") as? String {
//                        self?.delegate?.updateImageWith(asset: asset1, name:  name)
//                    }
//
//                    DispatchQueue.global(qos: .background).async {
//                        // Background Thread
//                        DispatchQueue.main.async {
//                            // Run UI Updates or call completion block
//                            self?.referencia = imgItem.name
//                            self?.locaLINDENT = asset!.localIdentifier
//
//                            print("\(self?.referencia)")
//                            print("\(self?.locaLINDENT)")
//
//                        }
//                    }
//
//
//
//                })
//
//            }
           
            ///////// NEW CODE
            
            //}
            //   cell.imgRef.image = imgItem.globalImage // 0 for example use indexpatch.row
            return cell
        }
    
     private func loadImages(){   // paused until i figure how to load with out adding to array
        ////////////////////////////

        //////////////////////////////////
        let fetchOptions = PHFetchOptions()
            fetchOptions.includeAssetSourceTypes = [.typeUserLibrary] //, .typeiTunesSynced, .typeCloudShared]

        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        assets.enumerateObjects({ [self] (asset, count, stop) in

            let fileName = asset.value(forKey: "originalFilename") as! String
//            fileName.replacingOccurrences(of: "", with: "")
            images[fileName] = asset
            print("imageAsset: \(fileName)")
        })
        
    }
    

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          userD.set(indexPath.row, forKey: "indexpath")
            userD.synchronize()
            
            if tap == true {
                tap = false
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.reloadData()
                return
            }
                   
            set = 2
            let imgItem = imageItemArray[indexPath.row]
    
            if didsearch == true {
                wasSearch = true
                
            }
       tableView.deselectRow(at: indexPath, animated: true)
          
            
            
            let imgItem1 = imageItemArray[indexPath.row]
            passReferencia = imgItem1.name
            
           
            
            performSegue(withIdentifier: "Menu2Registrar", sender: imgItem.name) // refArray1[indexPath.row]
            
           
                //destinationVC.submittedName = inputName.text
//       print("\(imgItem.name)")
//            var t = indexPath.row
           
           
         }
   
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         if set == 2 {
//
//        if let presenter = self.presentedViewController as? RegistrarReferencia {
//
//            presenter.secReferencia = passReferencia
//
//            presenter.existe = true
//            presenter.fromPedido = false
//            presenter.fromDetPedCrear = false
//            presenter.fromMenuaCustome = false
//            presenter.noSequence = false
//
//        }
//        }
        
        
        
        if set == 2 {
                let guest = segue.destination as! RegistrarReferencia
            guest.secReferencia = sender as! String
            guest.existe = true
            guest.fromPedido = false
            guest.fromDetPedCrear = false
            guest.fromMenuaCustome = false
            guest.noSequence = false
            guest.delegate = self
            guest.images = images
        }
        
        if set == 4 {
            let guest = segue.destination as! RegistrarReferencia
            guest.delegate = self
            guest.fromMenuaCustome = true
            guest.fromDetPedCrear = false
            guest.noSequence = true
            guest.existe = false
            guest.images = images
        }
    
    }
  
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        print("ESTO PASA AL SWIPE")
//        tableView.scrollToTop()
      
        
//         tableView.scrollToRow(at: [1,0], at: .top, animated: true)
        print("\(indexPath)")
        return "BORRAR ARTICULO"
        
    }
    
    // delete row with a swip
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        
        if editingStyle == .delete {
            ////
            let refreshAlert = UIAlertController(title: "ESTA SEGURO BORRAR ESTE                 PRODUCTO", message: """
                                                                                     
                                                                                     
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
            
            
            refreshAlert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
                //            self.salvarNuevoSuplidor(self)
                print("NO, FUE SELECCIONADO")
              
                return
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "SI", style: .cancel, handler: { (action: UIAlertAction!) in
                  deletearticulo()
                print("SI, FUE SELECIONADO")
            
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            
            
            /////
            //  let compareReferencia = refArray1[refArray1.count - 1 - indexPath.row].name
            
            func deletearticulo() {
            
              let compareReferencia = imageItemArray[indexPath.row].name
            imageItemArray.remove(at: indexPath.row)
          
            tableview.deleteRows(at: [indexPath], with: .fade)
     
           
            print(compareReferencia)
                      do {
              let searchresult9 = try DatabaseController.getContext().fetch(fetchRequestRef)
                for result9 in searchresult9 as [Referencia] {
                    if result9.referencia == compareReferencia {
                        DatabaseController.getContext().delete(result9)
                        DatabaseController.saveContext()
                    }
                    
                }
                
            } catch {
                
            }
            } // end func deleteartifuclo
            
        } // End IF Delete 
    }
    
    func MenuCrearArticulo() {
        
        
        
        let refreshAlert = UIAlertController(title: "MENU DE CREAR ARTICULOS ", message: """
                                                                                     
                                                                                     Opcion: CREAR REFERENCIA PERSONALIZADA
                                                                                     Podras crear un articulo con un
                                                                                     numero de referencia  y codigo de
                                                                                     barra Personalizado....
                                                                                     
                                                                                     
                                                                                     Opcion: CREAR REFERENCIA
                                                                                     Podras crear un Articulo con una
                                                                                     referencia generada por el sistema
                                                                                     """, preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "[ CREAR PERSONALIZADA ]", style: .default, handler: { (action: UIAlertAction!) in
            //            self.salvarNuevoSuplidor(self)
            print("CREAR PERSONALIZADO, FUE SELECCIONADO")
            self.set = 4

            self.performSegue(withIdentifier: "Menu2Registrar", sender: nil)
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "[ CREAR ARTICULO ]", style: .default, handler: { (action: UIAlertAction!) in
            //            self.MismoSuplidorSalvar()
            print("CREAR, FUE SELECIONADO")
            
             self.performSegue(withIdentifier: "Menu2Registrar", sender: nil)
//            self.set = 9
//            print("\(self.tranSecPed)")
//
//            self.performSegue(withIdentifier: "ListaPedido2Menua", sender: nil)
//            UserDefaults.standard.set(self.tranSecPed, forKey: "customPedido")
//
//            UserDefaults.standard.synchronize()
            
            
        }))
        refreshAlert.addAction(UIAlertAction(title: "[ CANCEL ]", style: .cancel, handler: { (action: UIAlertAction!) in
            //            self.salvarNuevoSuplidor(self)
            print("CANCEL , FUE SELECCIONADO")
            
            return
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func verpedidobutton(_ sender: Any) {
    
        
         performSegue(withIdentifier: "menu2ListaPedido", sender: nil)
        
    }
    
    @IBAction func botonInvrntario(_ sender: Any) {
    
      performSegue(withIdentifier: "menu2Inventario", sender: nil)
    }
    
    @IBAction func bottonconfiguracion(_ sender: Any) {

   performSegue(withIdentifier: "Menu2Configuracion", sender: nil)
   
}

//    @IBAction func bottonlistaviaje(_ sender: Any) {
//        performSegue(withIdentifier: "Menu2ListaViaje", sender: nil)
//    }
  
   
    @IBAction func didselect(_ sender: Any) {
        conSeg = tipoCompra.selectedSegmentIndex
        userD.set(conSeg, forKey: "segmentmenu")
        userD.synchronize()
        updateData()
        
        
    }
    
    
    
    @IBAction func addbutton(_ sender: Any) {
        
        MenuCrearArticulo()
        
//        performSegue(withIdentifier: "Menu2Registrar", sender: nil)
        
//        if segmentedControl.selectedSegmentIndex == 0 {
//            controlResult = "LOCAL"
//            userD.set(controlResult, forKey: "suplidor")
//            userD.synchronize()
//        }
//        if segmentedControl.selectedSegmentIndex == 1 {
//            controlResult = "FABRICA"
//            userD.set(controlResult, forKey: "suplidor")
//            userD.synchronize()
//        }
        

        
    }

   
    
    @IBAction func EnviarCompra(_ sender: UIButton) {
//        var vof = Bool()     //no encontre ningun uso
        var Price = String()
        var moneda = String()
        var llevaEmpMad = String()
        var empSeparado =  String()
        var colore = String()
        var notaconfirmacion = String()
        var facto = String()
        var numeroFoto = String()
        
        
        
        
        
        if addbuttonOutlet.isHidden == false {
            print("ULTIMO VIAJE ACTIVADO")
        
            if tipoCompra.selectedSegmentIndex == 0 {
                print("LOCAL ACTIVADO")
                for i in imageItemArray {
                   
                    arrayRef.append(i.name)
                    
                    
                }
            ////////////////////////////////////////////////////////////////////////
                var via = String()
                if let va = userD.object(forKey: "viajeactual") as? String {
                    via = "\(va)"
                }
                
                
                let dt = formatterDateTime()
                /////
                
                
                let fileName = "lindacompra.csv"
                
                let subfolder = "Pedidos Enviados"
                let folder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                guard var path = NSURL(fileURLWithPath: folder).appendingPathComponent(subfolder) else {
                    print("Unable to create URL")
                    return
                }
                
                try! FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: [:])
                path.appendPathComponent(fileName)
                
                //let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
                var csvText = ""
                print("CSV Path", path)
                
                
                
                
                
                
                /////
//                let fileName = "compraTotal.csv"
//        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
                csvText = "\n,\("NOMBRE DEL VIAJE:"),\(via),\n,\("FECHA:"),\(dt),\nLocal,Foto Num.,Referencia,Description,Cantidad EN Cajas,Cajas,Cantidad Total,Precio,Empaque de MADERA,Empaque Separado,Colores,Observacion\n"
                
                do {
                     let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
                    print("TOTAL DE REFERENCIA A BUSCAR: \(arrayRef.count)")

                        for result in searchResultRef as [Referencia] {
                    

                            for i in 0..<arrayRef.count {
                                if result.referencia == arrayRef[i] {
        /////////////////////////////////////////////////////////////////////////////////////////
                                    
         
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
                                    print("\(total)")
                                    let cantotal = "\(c)"
                                    
                                    
                                    if result.precioRmb <= 0 && result.precioUsd > 0 {  //USD

                                        Price = "\(result.precioUsd)"
                                        p = Double(result.precioUsd)
                                        p1 = p
//                                        vof = true
                                        total = c * p1   // USD

                                        moneda = "USD $ "
                                    } else if result.precioRmb > 0 && result.precioUsd <= 0 {   //RMB

                                        Price = "\(result.precioRmb)"

                                        moneda = "RMB $ "
                                        p = Double(result.precioRmb)
                                        //////////////////// OJO ACTUALIZAR A BUSCAR LA TASA DEL uLTIMO VIAJE RMB /////////////////////////////////
                                        p2 = p / 6.8    // introducir taza de viaje
                                        total = c * p2    // RMB
//                                        vof = false
                                    }
                                    
                                    

//                                let totalUsd = "\(total)"

                                    
                                    let refer = "\(result.referencia!)"
                                    let descrip = "\(result.descripcion!)"
                                    let canEnCaja = "\(result.cantidadEnCaja)"
                                    let Cajas = "\(result.caja)"
//                                    var cbar = "\(result.codigoDeBarra)"
                                    
                                    if let ty = result.empaqueConMadera {
                                    llevaEmpMad = ty // "\(result.empaqueConMadera!)"
                                    }
                                    
                                    
                                    if let ty1 = result.formaDeEmpaque {
                                    empSeparado = ty1 // "\(result.formaDeEmpaque!)"
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
                                    if let nuFo = result.nombreDeFoto1 {
                                        numeroFoto = nuFo //"\(result.nombreDeFoto1!)"
                                    } else {
                                        numeroFoto = "N/A"
                                    }
                                    
                                    if let calle = result.calle {
                                        facto = "\(result.suplidor!) Calle:\(calle)"
                                    } else {
                                        facto = "\(result.suplidor!)"
                                    }
                                    
                                    
//                                    let getdec = Double("\(totalUsd)")
//                                    var getdec2 = String(format: "%.2f", arguments: [getdec!])
                                    //                                String(format: "%.0f", arguments: [totalUsd])
                                    
                                    let getpre1 = Double("\(Price)")
                                    let getpre2 = String(format: "%.3f", arguments: [getpre1!])
                                    let getpre3 = moneda + getpre2
                                    
                                    let getcan1 = Double("\(cantotal)")
                                    let getcan2 = String(format: "%.0f", arguments: [getcan1!])
                                    
                                    let newLine = "\(facto),\(numeroFoto),\(refer),\(descrip),\(canEnCaja),\(Cajas),\(getcan2),\(getpre3),\(llevaEmpMad),\(empSeparado),\(colore),\(notaconfirmacion)\n"
                                    
                                    csvText.append(newLine)
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
       ////////////////////////////////////////////////////////////////////////////////////////////
                                }
                            }
                    
                    
                    }  // for result closure
                    do {
                        try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
                        //                print("File CREATED")
                        if MFMailComposeViewController.canSendMail() {
                            let mail = MFMailComposeViewController()
                            mail.mailComposeDelegate = self
                            mail.setToRecipients(["cajunsniper@hotmail.com"]) // CORREO A SER ENVIADO
                            mail.setSubject("ORDER TOYS PG 2018") // SUBJECT PEDIDO
                            mail.setMessageBody("<p>Please send all information to P02G@hotmail.com Email Thank you</p>", isHTML: true)
                            
                            present(mail, animated: true)
                            mail.addAttachmentData(NSData(contentsOf: path)! as Data, mimeType: "text/csv", fileName: "lindacompra.csv")
                        } else {
                            // show failure alert
                        }
                        
                        
                        
                    } catch {
                        print("Failed to create file")
                        print("\(error)")
                    }
                    
                    
                } catch {
                    print("ERROR")
                    
                }
  
           //////////////////////////////////////////////////////////////////////////
//                print("Total son \(arrayRef.count)")
                
            }
        
            arrayRef = []
        }
        
       
        
    
        
    } // end Button ENVIAR
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        tranSecPed = recuperarPed
//        secpedido2 = recuperarPed
        
        controller.dismiss(animated: true)
        //       self.performSegue(withIdentifier: "listaPedido2Pedido", sender: nil)
//        regreso = true
        viewDidLoad()
        
    }
    
    func getExchangeRate() {
        var rmbint = Double()
        var rdint = Double()
        
        
        
        let url = URL(string: "http://www.apilayer.net/api/live?access_key=7556ddb433d83926f7d38d9b0f5bdef4")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["quotes"] as? NSDictionary
                        {
                            print(rates)
                            if let currency = rates["USDCNY"]  //"USDCNY":6.904899,
                            {
                                print ("USD to RMB : \(currency)")
                                rmb = "\(currency)"
                                rmbint = Double(rmb)!
                                rmbint = Double(round(100*rmbint)/100)
                                
                                
                            }
                            if let currency = rates["USDDOP"]  //"USDCNY":6.904899,
                            {
                                print ("USD to DR : \(currency)")
                                rd = "\(currency)"
                                rdint = Double(rd)!
                                rdint = Double(round(100*rdint)/100)
                                
                            }
                            
                        }
                    }
                    catch
                    {
                        
                    }
                    
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                             // Run UI Updates or call completion block // llamar dentro del programa
                        
                            
                            self.labelRmb.text = "Taza $1 Usd - Rmb $\(rmbint)"
                           
                            self.labelRD.text = "Taza $1 Usd - Dop $\(rdint)"
                           
                           
                        }
                    }
                    
                    
                    
                    
                }
            }
        }
        task.resume()
        
    }

   
    
   
    
}  // end class


// TODO this would be better on its own class

public func formatterDateTime() -> String {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    formatter.dateFormat = "MMM dd yyyy"
//    formatter.dateFormat = "MMMM dd yyyy , EEE hh:mm a"
    let str = formatter.string(from: Date())
    
    return str
    
}


protocol GetsImageFromAsset {
    
}

extension GetsImageFromAsset {
    func getUIImage(asset: PHAsset) -> UIImage? {
        
        var img: UIImage?
        var w = 500
        var h = 500
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
//        options.version = .original     // comentado
        options.isSynchronous = true
//        options.deliveryMode = .fastFormat  // comentado
        //CGSize(width: 150, height: 150)
        if fromMenua == true {
            w = 150
            h = 150
 print(fromMenua)
            
        }
        
        manager.requestImage(for: asset, targetSize: CGSize(width: w, height: h), contentMode: .default, options: options) { (image, _) in
//            print("##: inside called")
            if let image = image {
                print(image)
                img = image
            }
        }
        //manager.cancelImageRequest(<#T##requestID: PHImageRequestID##PHImageRequestID#>)
        
        
//        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
//
//            if let data = data {
//                img = UIImage(data: data)
//            }
//        }
        return img
    }
}

struct FotoConReferencia {
    var fotoReferencia: String
    var imagen: UIImage
}

//extension UITableView {
//    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
//        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
//    }
//
//    func scrollToTop() {
//        let indexPath = IndexPath(row: 5, section: 0)
//        if self.hasRowAtIndexPath(indexPath: indexPath) {
//            self.scrollToRow(at: indexPath, at: .top, animated: true)
//        }
//    }
//
//}
//
