//
//  InventarioTableView.swift
//  sistemadecompra
//
//  Created by cajunsniper on 4/9/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//

import UIKit
import CoreData

class InventarioTableView: UITableViewController, UISearchBarDelegate {
 var set = 1
    var userD = UserDefaults.standard
    var dInventario = false
      var picArray = [UIImage(named:"Lamp")]
    
     fileprivate var imageItemArray1 = [ListaReferencia]()
      @IBOutlet var tableview1: UITableView!
    
 fileprivate func setUpSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))
        
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["REFERENCIA","DESCRIPCION","SUPLIDOR","TIPO DE MERCANCIA","VIAJE"]
        searchBar.selectedScopeButtonIndex = 0
        
        searchBar.delegate = self
        
        self.tableview1.tableHeaderView = searchBar
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //        tableview1.dataSource = self
//        tableview1.delegate = self

        updateData1()
        
        setUpSearchBar()
        dInventario = true
        
        
        userD.set(dInventario, forKey: "desde")
        userD.synchronize()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        updateData()
//        
    }
    func updateData1() {
        imageItemArray1 = CoreDataManager.fetchObjectInv()
        tableview1.reloadData()
    }

 func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            imageItemArray1 = CoreDataManager.fetchObjectInv()
            tableview1.reloadData()
            return
        }
        
        imageItemArray1 = CoreDataManager.fetchObjectInv(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText:searchText)
        tableview1.reloadData()
        print(searchText)
    }

    
    
       // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "PEDIDO NO  VIAJE SUPLIDOR"
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageItemArray1.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  var cell = self.tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         let cell1 = self.tableview1.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
      
        let imgItem = imageItemArray1[imageItemArray1.count - 1 - indexPath.row]
        
        cell1.textLabel?.text = imgItem.name
        cell1.detailTextLabel?.text = imgItem.descripcion
        
        
//        cell.img.image = picArray[0]   // 0 for example use indexpatch.row

        // Configure the cell...

        return cell1
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        set = 2
        
        let imgItem = imageItemArray1[imageItemArray1.count - 1 - indexPath.row]
        
        performSegue(withIdentifier: "inventario2Registrar", sender: imgItem.name) // refArray1[indexPath.row]
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if set == 2 {
            let guest = segue.destination as! RegistrarReferencia
            guest.secReferencia = sender as! String
            guest.existe = true
            // guest.localSup = controlResult
            
        }
        
        
    }
    
    // delete row with a swip
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //  let compareReferencia = refArray1[refArray1.count - 1 - indexPath.row].name
            let compareReferencia = imageItemArray1[imageItemArray1.count - 1 - indexPath.row].name
            imageItemArray1.remove(at: imageItemArray1.count - 1 - indexPath.row)
            
            tableview1.deleteRows(at: [indexPath], with: .fade)
            
            
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
            
        } // End IF Delete
    }

    

}
