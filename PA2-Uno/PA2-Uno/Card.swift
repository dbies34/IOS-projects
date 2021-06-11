//
//  Card.swift
//  PA2-Uno
//
//  Created by Drew Bies on 9/16/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

enum Color: String{
    case red = "🔴"
    case blue = "🔵"
    case green = "🟢"
    case yellow = "🟡"
    case wild = "🃏"
}

class Card: CustomStringConvertible{
    var color: Color = .red
    var name: String = ""
    // how the player sees their cards
    var description: String {
        return "\(color.rawValue)\(name)\(color.rawValue)"
    }
    // how you see the computer's cards
    var secretDescription: String{
        return "🎴"
    }
    
    init(color: Color, name: String) {
        self.color = color
        self.name = name
    }
    
}
