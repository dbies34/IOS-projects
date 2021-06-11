//
//  Trip+CoreDataProperties.swift
//  Traveler
//
//  Created by Drew Bies on 11/15/20.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var destinationName: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var imageFileName: String?
    @NSManaged public var startDate: Date?

}

extension Trip : Identifiable {

}
