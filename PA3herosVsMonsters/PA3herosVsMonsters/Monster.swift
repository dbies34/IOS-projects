//
//  Monster.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Monster: DungeonCharacter{
    var healChance: Double = 0.0
    var maxHeal: Int = 0
    var minHeal: Int = 0
    var poisonTurnsLeft: Int = 0
    
    init(){
        super.init(name: "", hitPoints: 0, attackSpeed: 0, maxDmg: 0, minDmg: 0, hitChance: 0.0)
    }
    
    init(name: String, hitPoints: Int, attackSpeed: Int, maxDmg: Int, minDmg: Int, hitChance: Double, healChance: Double, maxHeal: Int, minHeal: Int) {
        self.healChance = healChance
        self.maxHeal = maxHeal
        self.minHeal = minHeal
        super.init(name: name, hitPoints: hitPoints, attackSpeed: attackSpeed, maxDmg: maxDmg, minDmg: minDmg, hitChance: hitChance)
    }
    
    func heal() -> Int{
        if(Int.random(in: 1...10) <= Int(healChance * 10)){
            let heal = Int.random(in: minHeal...maxHeal)
            print("\t\(name) heals for \(heal) ❤️")
            return heal
        } else{
            print("\t\(name) unsuccessfully trys to heal.")
            return 0
        }
    }
}
