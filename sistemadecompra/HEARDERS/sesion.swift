//
//  sesion.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 3/18/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//

import Foundation

struct Section {
    var local: String!
    var itemno: [String]!
    var expanded: Bool!
    
    init(local: String, itemno: [String], expanded: Bool) {
        self.local = local
        self.itemno = itemno
        self.expanded = expanded
    }
    init() {
        local = "                                                                                          LISTA DE CONFIRMACION"
        itemno = []
        expanded = false
    }
}

/*
 let predicate = NSPredicate(format: "ANY det.numeroDePedido == %@", "\(resultv.local)")
 let predicate1 = NSPredicate(format:@"resulttv.local! = NULL")
 
 
  fetchRequestRef.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate1])
 
 
 do {
 let searchResultRef = try DatabaseController.getContext().fetch(fetchRequestRef)
 print("Cantidad de Referencia para Confirmar en local: \(resultv.local) es: \(searchResultRef.count)" )
 
 for result in searchResultRef as [Referencia] {
 
 count = searchResultRef.count
 
 
 
 
 
 
 
 
 
 
 
 print("PEDIDO DEL DE AHORA  \(resultv.numeroDePedido)  TIENE \(count) ")
 
 myDict["referencia"] = "\(result.referencia!)"
 myDict["descripcion"] = "\(result.descripcion!)"
 myDict["cantidadencaja"] = "\(result.cantidadEnCaja)"
 
 
 
 
 
 myArray.append(myDict)
 
 }


*/





