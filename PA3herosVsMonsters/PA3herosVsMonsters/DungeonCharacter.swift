//
//  DungeonCharacter.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class DungeonCharacter: CustomStringConvertible{
    var name: String
    var hitPoints: Int
    var attackSpeed: Int
    var maxDmg: Int
    var minDmg: Int
    var hitChance: Double
    var description: String{
        return name
    }
    
    init(name: String, hitPoints: Int, attackSpeed: Int, maxDmg: Int, minDmg: Int, hitChance: Double){
        self.name = name
        self.hitPoints = hitPoints
        self.attackSpeed = attackSpeed
        self.maxDmg = maxDmg
        self.minDmg = minDmg
        self.hitChance = hitChance
    }
    
    // special attack 
    func special() -> Int{
        return 0
    }
    
    // returns an attack number based on attack range and hit chance
    func attack() -> Int{
        let rand = Int.random(in: 1...10)
        if(rand < Int(hitChance * 10)){
            return Int.random(in: minDmg...maxDmg)
        } else{
            return 0
        }
    }
}
