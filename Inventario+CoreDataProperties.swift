//
//  Inventario+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Inventario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inventario> {
        return NSFetchRequest<Inventario>(entityName: "Inventario")
    }

    @NSManaged public var inventarioGeneral: String?
    @NSManaged public var ref: Referencia?

}
