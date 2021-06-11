//
//  Hero.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Hero: DungeonCharacter{
    var dodgeChance: Double = 0.5
    var numOfTurns: Int = 2
    
    init(){
        super.init(name: "", hitPoints: 0, attackSpeed: 1, maxDmg: 0, minDmg: 0, hitChance: 0.0)
    }
    
    init(name: String, hitPoints: Int, attackSpeed: Int, maxDmg: Int, minDmg: Int, hitChance: Double, numOfTurns: Int, dodgeChance: Double) {
        self.numOfTurns = numOfTurns
        self.dodgeChance = dodgeChance
        super.init(name: name, hitPoints: hitPoints, attackSpeed: attackSpeed, maxDmg: maxDmg, minDmg: minDmg, hitChance: hitChance)
    }
    
    // returns the name of the character
    func getName() -> String{
        return name
    }
}
