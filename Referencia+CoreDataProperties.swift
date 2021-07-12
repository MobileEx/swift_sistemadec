//
//  Referencia+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Referencia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Referencia> {
        let request = NSFetchRequest<Referencia>(entityName: "Referencia")
        
    //  request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        return request
        
    }

    @NSManaged public var caja: Int32
    @NSManaged public var calle: String?
    @NSManaged public var cantidadEnCaja: Int32
    @NSManaged public var categoria: String?
    @NSManaged public var cbm: Double
    @NSManaged public var cbmtotal: Double
    @NSManaged public var codigoDeBarra: Int64
    @NSManaged public var colores: String?
    @NSManaged public var coloresPorciento: String?
    @NSManaged public var confirmacion: Bool
    @NSManaged public var descripcion: String?
    @NSManaged public var empaqueConMadera: String?
    @NSManaged public var fabrica: Bool
    @NSManaged public var formaDeEmpaque: String?
    @NSManaged public var foto1: NSData?
    @NSManaged public var foto2: NSData?
    @NSManaged public var foto3: NSData?
    @NSManaged public var fotoDeTargeta: NSData?
    @NSManaged public var fotoReferencia: String?
    @NSManaged public var fotoReferencia2: String?
    @NSManaged public var libras: Double
    @NSManaged public var llevaPocientoAdicional: Bool
    @NSManaged public var llevaSelectivo: Bool
    @NSManaged public var local: String?
    @NSManaged public var nombreDeFoto1: String?
    @NSManaged public var nombreDefoto2: String?
    @NSManaged public var nombreDeFoto3: String?
    @NSManaged public var nombreDeFotoTargeta: String?
    @NSManaged public var observacion: String?
    @NSManaged public var porcientoAdicional: Double
    @NSManaged public var ppv: Double
    @NSManaged public var precioRmb: Double
    @NSManaged public var precioUsd: Double
    @NSManaged public var referencia: String?
    @NSManaged public var savedRefLet: String?
    @NSManaged public var savedRefNum: Int32
    @NSManaged public var suplidor: String?
    @NSManaged public var det: NSSet?
    @NSManaged public var inv: Inventario?
    @NSManaged public var via: Viaje?
    @NSManaged public var tamanoencm: Double

}

// MARK: Generated accessors for det
extension Referencia {

    @objc(addDetObject:)
    @NSManaged public func addToDet(_ value: Detalle)

    @objc(removeDetObject:)
    @NSManaged public func removeFromDet(_ value: Detalle)

    @objc(addDet:)
    @NSManaged public func addToDet(_ values: NSSet)

    @objc(removeDet:)
    @NSManaged public func removeFromDet(_ values: NSSet)

}
