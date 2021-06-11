//
//  Thief.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class Thief: Hero{
    override var description: String{
        return "\(super.description) the Thief"
    }
    
    init(name: String) {
        super.init(name: name, hitPoints: 75, attackSpeed: 6, maxDmg: 40, minDmg: 20, hitChance: 0.8, numOfTurns: 2, dodgeChance: 0.2)
    }

    // suprise attack
    override func special() -> Int{
        // 40 percent chance the surprise attack is successful. If it is successful, Thief gets a normal attack and another turn in the current round. There is a 20 percent chance the Thief is caught in which case no attack is rendered. The other 40 percent is just a normal attack
        print("\t\(description) goes for the SURPRISE ATTACK!")
        print("\tA surprise attack is a normal attack plus an extra turn in the round")
        let rand = Int.random(in: 1...10)
        let attack = super.attack()
        if(rand <= 4){
            numOfTurns += 1
            if(attack > 0){
                print("\tSURPRISE ATTACK lands for \(attack) ❤️")
            } else{
                print("\t\(description) misses but still recieves an extra turn")
            }
            return attack
        } else if(rand <= 6){
            print("\t\(description) was caught and missed the attack")
            return 0
        } else{
            if(attack > 0){
                print("\t\(description) was caught but still attacks for \(attack) ❤️")
            } else{
                print("\t\(description) was caught and failed to hit")
            }
            return attack
        }
    }
}
