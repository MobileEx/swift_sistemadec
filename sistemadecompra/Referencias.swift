//
//  Referencias.swift
//  sistemadecompra
//
//  Created by cajunsniper on 3/22/17.
//  Copyright © 2017 cajunsniper. All rights reserved.
//
import UIKit
import CoreData


public var didsearch = Bool()
public var didsearchInv = Bool()

struct ListaReferencia {
    var foto: UIImage?
   var name: String
    var descripcion: String
    var fotoReferencia: String? = nil
    var globalImage:UIImage? = nil
    var fotoReferencia2: String? = nil
    var nombrePic: String? = nil
    var precio: String? = nil
    var ppv: String? = nil
    var precioUsd : String?
    
    
    
    init() {
        name = ""
        descripcion = ""
        globalImage = nil
    }
    init(name: String,description: String, imagen:UIImage? = nil, fotoReferencia: String? = nil, fotoReferencia2: String? = nil, precio: String?, precioUsd : String?, ppv: String?, nombrePic: String?) {
        self.name = name
        self.descripcion = description
       self.globalImage = imagen
    self.fotoReferencia = fotoReferencia
        self.fotoReferencia2 = fotoReferencia2
        self.precio = precio
        self.precioUsd = precioUsd
        self.ppv = ppv
        self.nombrePic = nombrePic

    }

}




    class CoreDataManager: NSObject {
        
        class func fetchObj(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [ListaReferencia]{
            var aray = [ListaReferencia]()
            let userD = UserDefaults.standard
           var nomvia = String()
            var buscar:Bool = false
            var predicate = NSPredicate()
//            var foto:UIImage? = nil
            var supli = String()
            var res = "TOTAL"
            didsearch = true
           
            
            
            //            var mydic:Dictionary<Int:String>
            
//            if searchText != "" {
//                targetText = searchText
//            }
            
            if let varViaje = userD.object(forKey: "nombreDelViaje") as? String {
               
                nomvia = varViaje
            }
              let predicate1 = NSPredicate(format: "ANY via.nombreDelViaje == %@", "\(nomvia)")
            print("NO DEVE ESTAR AKI ADENTRO")
            if selectedScopeIdx != nil && targetText != nil{
                buscar = true
                var filterKeyword = ""
                userD.set(selectedScopeIdx!, forKey: "seleccion")
                userD.set(targetText, forKey: "searchtext")
                userD.synchronize()
                
                switch selectedScopeIdx! {
                case 0:
                    
                    filterKeyword = "referencia"      // atrib from entity
                case 1:
                    filterKeyword = "descripcion"
                default:
                    filterKeyword = "suplidor"
                }
                
                
                
                predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", (targetText?.lowercased())!)
               
            } else {
                wasSearch = false
                didsearch = false
                userD.set(0, forKey: "seleccion")
                userD.set("", forKey: "searchtext")
                userD.synchronize()
            }
            
            if buscar == true {
             
                   fetchRequestRef.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate1])
            } else {
            
            fetchRequestRef.predicate = predicate1
            }
            
            do {
                let fetchResult = try DatabaseController.getContext().fetch(fetchRequestRef)
                
                for item in fetchResult {
                   
                   

                    let letters = CharacterSet.letters
                    let digits = CharacterSet.decimalDigits
                    
                    var letterCount = 0
                    var digitCount = 0
                    
                    let phrase = "\(String(describing: item.suplidor))"
                    for uni in phrase.unicodeScalars {
                        
                        if letters.contains(uni) {
                            letterCount += 1
                        } else if digits.contains(uni) {
                            digitCount += 1
                        }
                    }
                    print("DIGITS: \(letterCount) Numbers: \(digitCount)")
                    if digitCount > 1 {
                        supli = "FACTORIA"     /// "LOCAL"
                        
                    
                        
                    } else {
                       
                        
                      supli = "LOCAL"    /// "FACTORIA"
                        
                    }
                    
                    
                
                    if let der = userD.object(forKey: "segmentmenu") as? Int {
                        
                        switch der {
                     
                        case 0:

                                res = "LOCAL"
                        case 1:

                                res = "FACTORIA"
                        case 2:

                                res = "TODAS"
                        default:
                            print("NONE")
                    }
                    
                    
                        
                    if supli != res {
                    
//                    let img = ListaReferencia(name: item.referencia!, description: item.descripcion!, fotoReferencia: item.fotoReferencia)
                   let img = ListaReferencia.init(name: item.referencia!, description: item.descripcion!, fotoReferencia: item.fotoReferencia, precio: String("\(item.precioRmb)"), precioUsd: String("\(item.precioUsd)"), ppv: String("\(item.ppv)"), nombrePic: item.nombreDeFoto1)
                        
                        
                        aray.append(img)
                    
                    }
                        
                    
                    
                        
                        
                        
                        
                    }
                    
                    
                    
//                    print("Referencia: "+img.name+"\nDescripcion:"+img.descripcion+"\n")
                    //            print("\(aray)\n")
                    
                }
            }catch {
                print(error.localizedDescription)
            }
            
//            if targetText == nil {
//                return aray.reversed()
//            } else {
                return aray
//            }
            
        }

        /////////////////
        
        
        
        
        class func fetchObjectInv(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [ListaReferencia]{
            
          let userD = UserDefaults.standard
            
          var filterKeyword = "Referencia"
            
            var aray1 = [ListaReferencia]()
            
            aray1 = []
           
//            var buscar:Bool = false
            var predicate = NSPredicate()
//            var nomvia = targetText  // CAHNGER WARNING

           
            
            
            
  if selectedScopeIdx != nil && targetText != nil{
    userD.set(selectedScopeIdx!, forKey: "seleccionInv")
    userD.set(targetText, forKey: "searchtextInv")
    userD.synchronize()
//                buscar = true
                didsearchInv = true
                filterKeyword = ""
                switch selectedScopeIdx! {
                case 0:
                    filterKeyword = "referencia"      // atrib from entity
                     predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", (targetText?.lowercased())!)
                case 1:
                    filterKeyword = "descripcion"
                     predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", (targetText?.lowercased())!)
                case 2:
                    filterKeyword = "suplidor"
                     predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", (targetText?.lowercased())!)
                case 3:
                    filterKeyword = "categoria"
                     predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", (targetText?.lowercased())!)
                    
                default:    /////////////////////////////////////////////
                    
                    do {
                        let searchResultsViaje = try DatabaseController.getContext().fetch(fetchRequestVia)
                        
                        //  print("Result of VIAJES: \(searchResultsViaje.count)")
                        
                        for resultv in searchResultsViaje as [Viaje] {
                            
                            if resultv.nombreDelViaje != nil {
                                

                    
                 
                    filterKeyword = "nombreDeViaje"
                    predicate = NSPredicate(format: "ANY via.nombreDelViaje == %@", "\(resultv.nombreDelViaje!)")
                    

                            }
                        }
                    }catch {
                        
                    }
                    
                            
                            
                            
                            
                }
                
                
//                
//                predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", (targetText?.lowercased())!)
                
                
                fetchRequestRef.predicate = predicate
            } else {
                
                     didsearchInv = false
                     wasSearchInv = false
                    userD.set(0, forKey: "seleccionInv")
                    userD.set("", forKey: "searchtextInv")
                    userD.synchronize()
    
//                predicate = NSPredicate(format: "referencia CONTAINS[c] %@", "P")
// hay que buscar en configuracion principal las letras de la ref y sacar la primera y ponerla en el predicate an vez de un a "P"  arriba

                fetchRequestRef.predicate = nil //predicate
    
            }
            
      
            
            do {
                let fetchResult = try DatabaseController.getContext().fetch(fetchRequestRef)
                
                for item in fetchResult {
                    
                    
//                    let img = ListaReferencia(name: item.referencia!, description: item.descripcion!, fotoReferencia: item.fotoReferencia)
                    let img = ListaReferencia.init(name: item.referencia!, description: item.descripcion!, fotoReferencia: item.fotoReferencia, precio: String("\(item.precioRmb)"),precioUsd: String("\(item.precioUsd)"), ppv: String("\(item.ppv)"), nombrePic: item.nombreDeFoto1)
                    aray1.append(img)
                    
                    print("Referencia: "+img.name+"\nDescripcion:"+img.descripcion+"\n")
                    //            print("\(aray)\n")
                    
                }
            }catch {
                print(error.localizedDescription)
            }
            
            return aray1
        }

    }

    

    






