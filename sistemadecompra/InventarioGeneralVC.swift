//
//  InventarioGeneralVC.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/11/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import Photos
public var wasSearchInv = false

class InventarioGeneralVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, GetsImageFromAsset {
    var set = 1
    var tut = false
    var userD = UserDefaults.standard
    @IBOutlet weak var tableview: UITableView!
    var dInventario = false
    var picArray = [UIImage]()
     fileprivate var arrayReferencias = [ListaReferencia]()
    var fotos = [UIImage]()
    var ind = Int()
    var tex = String()
    
    override func viewDidAppear(_ animated: Bool) {
        set = 1
        
         updateData1()
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
fromMenua = true
        tut = true
        userD.set(tut, forKey: "desde")
        userD.synchronize()
        
        updateData1()
             setUpSearchBar()
        dInventario = true
        
        
        userD.set(dInventario, forKey: "desde")
        userD.synchronize()

        
        // Do any additional setup after loading the view.
    }


    func updateData1() {
        if wasSearchInv == true {
            if let tf = userD.object(forKey: "seleccionInv") as? Int {
                ind = tf
            }
            if let tf1 = userD.object(forKey: "searchtextInv") as? String {
                tex = tf1
            }
            
            
            arrayReferencias = CoreDataManager.fetchObjectInv(selectedScopeIdx: ind, targetText: tex)
            
        } else {
            
            arrayReferencias = CoreDataManager.fetchObjectInv()
        }
       
        
        tableview.reloadData()
    }
    
    
    
    // HEADER FOR PEDIDO
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return "PEDIDO NO  VIAJE SUPLIDOR"
//    }

    
    fileprivate func setUpSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
        
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["REFERENCIA","DESCRIPCION","SUPLIDOR","TIPO DE MERCANCIA"]
        
        if wasSearchInv == true {
            if let tf = userD.object(forKey: "seleccionInv") as? Int {
                ind = tf
            }
            if let tf1 = userD.object(forKey: "searchtextInv") as? String {
                tex = tf1
            }
            searchBar.selectedScopeButtonIndex = ind
            searchBar.text = tex
        } else {
            searchBar.selectedScopeButtonIndex = 0
        }
        
        searchBar.delegate = self
        
        self.tableview.tableHeaderView = searchBar
      
//        self.view.addSubview(searchBar)
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            arrayReferencias = CoreDataManager.fetchObjectInv()
        
            tableview.reloadData()
            return
        }
        /// aki
//        arrayReferencias = CoreDataManager.fetchObj(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText:searchText)
        
        
        arrayReferencias = CoreDataManager.fetchObjectInv(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText: searchText)
        
        
        
        arrayReferencias = arrayReferencias.reversed()
        tableview.reloadData()

        print(searchText)
    }

    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayReferencias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellInventario
        /////////////////////////////////////////////
        let imgItem = arrayReferencias[indexPath.row]
        
        cell.reflabel.text = imgItem.name
        
        
        cell.desclabel.text = imgItem.descripcion
        
        

            if cell.imgref != nil {
                
                if let varfoto1 = imgItem.fotoReferencia {
                    
                 
                    let asset = PHAsset.fetchAssets(withLocalIdentifiers: [varfoto1], options: nil)
                    
                    if asset.count > 0 {
                        cell.imgref.image = getUIImage(asset: asset[0])
                    }
               
                    
                }

                
                
           

        }
  
        return cell
        
        
        

    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        set = 2
    if didsearchInv == true {
        wasSearchInv = true
    }
        let imgItem = arrayReferencias[indexPath.row]

        tableView.deselectRow(at: indexPath, animated: true)
    
        performSegue(withIdentifier: "inventario2Regitrar", sender: imgItem.name)
    // refArray1[indexPath.row]
        
    }

    
    @IBAction func bottonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
//        performSegue(withIdentifier: "inventario2Menu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if set == 2 {
            let guest = segue.destination as! RegistrarReferencia
            guest.secReferencia = sender as! String
            guest.existe = true
             guest.fromPedido = false
            
        }
    }

    
    // delete row with a swip
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //  let compareReferencia = refArray1[refArray1.count - 1 - indexPath.row].name
//            let compareReferencia = arrayReferencias[indexPath.row].name
//            arrayReferencias.remove(at: indexPath.row)
//
//            tableview.deleteRows(at: [indexPath], with: .fade)
//
//
//            print(compareReferencia)
//            do {
//                let searchresult9 = try DatabaseController.getContext().fetch(fetchRequestRef)
//                for result9 in searchresult9 as [Referencia] {
//                    if result9.referencia == compareReferencia {
//                        DatabaseController.getContext().delete(result9)
//                        DatabaseController.saveContext()
//                    }
//
//                }
//
//            } catch {
//
//            }
//
//        } // End IF Delete
    
    }
}

