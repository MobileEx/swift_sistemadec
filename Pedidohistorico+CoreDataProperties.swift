//
//  Pedidohistorico+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Pedidohistorico {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pedidohistorico> {
        return NSFetchRequest<Pedidohistorico>(entityName: "Pedidohistorico")
    }

    @NSManaged public var cajas: String?
    @NSManaged public var cantidadencaja: String?
    @NSManaged public var cantidadtotal: String?
    @NSManaged public var fecha: String?
    @NSManaged public var numerodepedido: String?
    @NSManaged public var preciodeventa: String?
    @NSManaged public var moneda: String?
    @NSManaged public var precio: String?
    @NSManaged public var referencia: String?
    

}
