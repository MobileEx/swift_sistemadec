//
//  Configuracion+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Configuracion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Configuracion> {
        return NSFetchRequest<Configuracion>(entityName: "Configuracion")
    }

    @NSManaged public var cdbFin: Int64
    @NSManaged public var cdbPri: Int64
    @NSManaged public var cdbSec: Int64
    @NSManaged public var claveActual: Int32
    @NSManaged public var direccion: String?
    @NSManaged public var email: String?
    @NSManaged public var ext: String?
    @NSManaged public var fax: String?
    @NSManaged public var nombre: String?
    @NSManaged public var pais: String?
    @NSManaged public var principioPedido: Int32
    @NSManaged public var reffLet: String?
    @NSManaged public var reffNum: Int32
    @NSManaged public var reffSecNum: Int32
    @NSManaged public var reffSup: String?
    @NSManaged public var refLet: String?
    @NSManaged public var refNum: Int32
    @NSManaged public var refSecNum: Int32
    @NSManaged public var rnc: String?
    @NSManaged public var secuenciaconfirmacion: Int32
    @NSManaged public var secuenciaPedido: Int32
    @NSManaged public var telefono: String?
    @NSManaged public var tipo: String?
    @NSManaged public var mark: String?

}
