//
//  Favorite+CoreDataProperties.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var imageUrl: String?

}

extension Favorite : Identifiable {

}
