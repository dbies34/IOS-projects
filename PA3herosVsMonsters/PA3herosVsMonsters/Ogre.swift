//
//  Ogre.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Ogre: Monster{
    override var description: String{
        return name
    }
    override init() {
        super.init(name: "Tim the Ogre", hitPoints: 200, attackSpeed: 2, maxDmg: 60, minDmg: 30, hitChance: 0.6, healChance: 0.1, maxHeal: 60, minHeal: 30)
    }
    
    // body slam
    override func special() -> Int{
        print("\t\(name) goes for a BODY SLAM")
        let dmg = Int.random(in: 50...75)
        let recoil: Int = dmg / 2
        print("\tYou are hit for \(dmg) ❤️ and \(name) loses \(recoil) ❤️ due to recoil")
        hitPoints -= recoil
        return dmg
    }
}
