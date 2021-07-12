//
//  Detalle+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Detalle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detalle> {
     
       
        
//        return NSFetchRequest<Detalle>(entityName: "Detalle")
        
     
        return NSFetchRequest<Detalle>(entityName: "Detalle")
//
//        let request = NSFetchRequest<Detalle>(entityName: "Detalle")
        
//        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
//        return request
//
    }

    @NSManaged public var cantidaDecajas: Int32
    @NSManaged public var cantidadTotal: Int32
    @NSManaged public var enviado: Bool
    @NSManaged public var numeroDePedido: Int32
    @NSManaged public var precioDeVenta: Double
    @NSManaged public var ref: NSSet?
    @NSManaged public var via: Viaje?
    @NSManaged public var totalcbm: Double
    @NSManaged public var timestamp: Date

}

// MARK: Generated accessors for ref
extension Detalle {

    @objc(addRefObject:)
    @NSManaged public func addToRef(_ value: Referencia)

    @objc(removeRefObject:)
    @NSManaged public func removeFromRef(_ value: Referencia)

    @objc(addRef:)
    @NSManaged public func addToRef(_ values: NSSet)

    @objc(removeRef:)
    @NSManaged public func removeFromRef(_ values: NSSet)

}
