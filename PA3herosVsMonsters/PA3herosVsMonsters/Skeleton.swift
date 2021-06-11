//
//  Skeleton.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Skeleton: Monster{
    override var description: String{
        return name
    }
    override init() {
        super.init(name: "Steven the Skeleton", hitPoints: 100, attackSpeed: 3, maxDmg: 50, minDmg: 30, hitChance: 0.8, healChance: 0.3, maxHeal: 50, minHeal: 30)
    }
    
    // life drain
    override func special() -> Int {
        print("\t\(name) goes for LIFE DRAIN")
        let dmg = Int.random(in: 10...15)
        print("\t\(dmg) ❤️ is stolen from you")
        hitPoints += dmg
        return dmg
    }
}
