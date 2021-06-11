//
//  Cell.swift
//  Carpet Fishing
//
//  Created by Drew Bies on 10/17/20.
//

import Foundation

class Cell: CustomStringConvertible{
    var row: Int
    var col: Int
    var containsLine: Bool = false
    var containsFish: Bool = false
    var fish: String? {
        didSet{
            containsFish = getFish() != ""
        }
    }
    var description: String{
        if(containsLine){
            if(containsFish){
                return "🎣"
            } else{
                return "⌇"
            }
        } else{
            if(containsFish){
                return getFish()
            } else{
                return "🌊"
            }
        }
    }
    
    // initialize the cell
    init(row: Int, col: Int, fish: String){
        self.row = row
        self.col = col
        self.fish = fish
    }
    
    // unwraps and returns the fish from the cell
    private func getFish() -> String{
        guard let fishStr = fish else {
            return ""
        }
        return fishStr
    }
}
