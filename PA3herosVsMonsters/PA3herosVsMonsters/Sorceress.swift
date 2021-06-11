//
//  Sorceress.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Sorceress: Hero{
    override var description: String{
        return "\(super.description) the Sorceress"
    }
    
    init(name: String) {
        super.init(name: name, hitPoints: 75, attackSpeed: 6, maxDmg: 40, minDmg: 20, hitChance: 0.8, numOfTurns: 2, dodgeChance: 0.4)
    }
    
    // heal
    override func special() -> Int{
        // choose a range of hit points that will be healed
        let heal = Int.random(in: 10...30)
        print("\(description) is healed for \(heal) ❤️!")
        return heal
    }
}
