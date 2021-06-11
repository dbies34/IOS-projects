//
//  Gremlin.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Gremlin: Monster{
    override var description: String{
        return name
    }
    override init() {
        super.init(name: "Frank the Gremlin", hitPoints: 70, attackSpeed: 5, maxDmg: 30, minDmg: 15, hitChance: 0.8, healChance: 0.4, maxHeal: 40, minHeal: 20)
    }
    
    // poison jab
    override func special() -> Int {
        print("\t\(name) uses POISON JAB")
        let dmg = Int.random(in: minDmg...maxDmg)
        print("\tYou lose \(dmg) ❤️ and are poisoned for 3 turns")
        poisonTurnsLeft += 3
        return dmg
    }
}
