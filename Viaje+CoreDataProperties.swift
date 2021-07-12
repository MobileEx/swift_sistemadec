//
//  Viaje+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Viaje {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Viaje> {
        return NSFetchRequest<Viaje>(entityName: "Viaje")
    }

    @NSManaged public var aduanaMasGastos: Double
    @NSManaged public var fleteMaritimo: Double
    @NSManaged public var ganaciaCumpleano: Double
    @NSManaged public var salarioxhora: Double
    @NSManaged public var ganaciaGeneral: Double
    @NSManaged public var impuestoItebis: Double
    @NSManaged public var materialRelleno: Double
    @NSManaged public var nombreDelViaje: String?
    @NSManaged public var selectivo: Double
    @NSManaged public var tazaRmb: Double
    @NSManaged public var tazaUsd: Double
    @NSManaged public var det: Detalle?
    @NSManaged public var ref: NSSet?

}

// MARK: Generated accessors for ref
extension Viaje {

    @objc(addRefObject:)
    @NSManaged public func addToRef(_ value: Referencia)

    @objc(removeRefObject:)
    @NSManaged public func removeFromRef(_ value: Referencia)

    @objc(addRef:)
    @NSManaged public func addToRef(_ values: NSSet)

    @objc(removeRef:)
    @NSManaged public func removeFromRef(_ values: NSSet)

}
