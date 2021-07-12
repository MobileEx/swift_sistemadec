//
//  Autenticacion+CoreDataProperties.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/11/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//
//

import Foundation
import CoreData


extension Autenticacion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Autenticacion> {
        return NSFetchRequest<Autenticacion>(entityName: "Autenticacion")
    }

    @NSManaged public var clave: Int32
    @NSManaged public var email: String?

}
