//
//  TripStruct.swift
//  Traveler
//
//  Created by Drew Bies on 11/15/20.
//

import Foundation

class TripStruct: CustomStringConvertible {
    var destinationName: String
    var startDate: Date
    var endDate: Date
    var imageFileName: String?
    var description: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return "Destination: \(destinationName) Dates: \(dateFormatter.string(from: startDate)) - \(dateFormatter.string(from: endDate))"
    }
    
    // initalize the properties
    init(destinationName: String, startDate: Date, endDate: Date, imageFileName: String?) {
        self.destinationName = destinationName
        self.startDate = startDate
        self.endDate = endDate
        self.imageFileName = imageFileName
    }
}
