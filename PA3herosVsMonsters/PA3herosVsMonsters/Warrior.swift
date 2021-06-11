//
//  Warrior.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Warrior: Hero{
    override var description: String{
        return "\(super.description) the Warrior"
    }
    
    init(name: String) {
        super.init(name: name, hitPoints: 125, attackSpeed: 4, maxDmg: 60, minDmg: 35, hitChance: 0.8, numOfTurns: 2, dodgeChance: 0.2)
    }
    
    // crushing blow
    override func special() -> Int{
        // 75 to 175 points of damage but only has a 40% chance of succeeding
        print("\t\(description) goes for the CRUSHING BLOW!")
        if(Int.random(in: 1...10) <= 4){
            let dmg = Int.random(in: 75...175)
            print("\tCrushing blow hits for \(dmg) ❤️!!!")
            return dmg
        } else{
            print("\tCrushing blow misses")
            return 0
        }
    }
}
