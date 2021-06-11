//
//  Place.swift
//  Near Me
//
//  Created by Drew Bies on 12/5/20.
//

import Foundation


class Place: CustomStringConvertible {
    var id: String
    var name: String
    var vicinity: String
    var rating: Double
    var photoReference: String
    var isOpen: Bool
    var description: String {
        return "\(name), \(id), \(vicinity), \(rating), \(photoReference), is open: \(isOpen)" 
    }
    
    init(id: String, name: String, vicinity: String, rating: Double, isOpen: Bool, photoReference: String) {
        self.id = id
        self.name = name
        self.vicinity = vicinity
        self.rating = rating
        self.photoReference = photoReference
        self.isOpen = isOpen
    }
}
