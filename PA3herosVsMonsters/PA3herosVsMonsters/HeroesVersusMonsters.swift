//
//  HeroesVersusMonsters.swift
//  PA3herosVsMonsters
//
//  Created by Drew Bies on 9/26/20.
//

import Foundation

class HeroesVersusMonsters{
    var hero: Hero = Hero()
    var monster: Monster = Monster()
    var name: String = ""
    var turn: Int = 1
    var maxTurns: Int = 0
    var isHeroesTurn: Bool = true
    var heroID: Int = 0
    
    func playGame(){
        var gameOver = false
        print("Welcome to Heroes vs. Monsters!")
        print("Please choose your hero from the following options:")
        print("\t1) Warrior \n\t2) Sorceress \n\t3) Thief")
        heroID = getInput()
        
        print("What is the name of your hero?")
        var nameOp = readLine()
        if let heroName = nameOp{
            nameOp = String(heroName)
            // assign the hero
            switch heroID {
                case 1:
                    hero = Warrior(name: nameOp!)
                case 2:
                    hero = Sorceress(name: nameOp!)
                case 3:
                    hero = Thief(name: nameOp!)
                default: break
            }
        }
        
        // randomly choose monster
        switch Int.random(in: 1...3) {
        case 1:
            monster = Ogre()
        case 2:
            monster = Gremlin()
        case 3:
            monster = Skeleton()
        default: break
        }
        print("Your hero is battling \(monster)")
        pressEnterToContinue()
        
        // set number of turns for hero based on attack speed
        if(monster.attackSpeed >= hero.attackSpeed){
            hero.numOfTurns = 1
        } else{
            hero.numOfTurns = hero.attackSpeed / monster.attackSpeed
        }
        maxTurns = hero.numOfTurns
        
        // game loop
        while(!gameOver){
            // check for poison status
            if(monster.poisonTurnsLeft > 0){
                let dmg = Int.random(in: 5...8)
                print("\t\(hero) is hurt by poison and loses \(dmg) ❤️\n")
                monster.poisonTurnsLeft -= 1
                hero.hitPoints -= dmg
            }
            if(isHeroesTurn){
                print("~~~\(hero)'s turn (\(turn) of \(hero.numOfTurns))~~~")
            } else{
                print("~~~\(monster)'s turn~~~")
            }
            
            print("\t\(hero): \(hero.hitPoints) ❤️")
            print("\t\(monster): \(monster.hitPoints) ❤️\n")
            if(isHeroesTurn){
                printMenu()
                switch getInput() {
                    case 1:
                        // normal attack
                        print("\t\(hero) is going for a normal attack")
                        let attack = hero.attack()
                        if(attack > 0){
                            print("\t\(monster) loses \(attack) ❤️")
                            monster.hitPoints -= attack
                            healMonster()
                        } else{
                            print("\t\(hero) swings at \(monster) and misses")
                        }
                        
                    case 2:
                        // specials
                        let special = hero.special()
                        if(heroID == 2){
                            // sorceress heal
                            hero.hitPoints += special
                        } else if(special > 0){
                            // warrior or thief special attack
                            monster.hitPoints -= special
                            healMonster()
                        }
                    case 3:
                        // quit game
                        print("Thank you for playing!")
                        exit(0)
                    default: break
                }
                turn += 1
                // check if out of turns
                if(turn > hero.numOfTurns){
                    isHeroesTurn = false
                }
                pressEnterToContinue()
            } else{
                // monster's turn
                if(Int.random(in: 1...10) <= 4){
                    // do special attack
                    hero.hitPoints -= monster.special()
                } else{
                    // normal attack
                    print("\t\(monster) lunges at \(hero)")
                    let attack = monster.attack()
                    if(attack > 0 && (Int.random(in: 1...10) >= Int(hero.dodgeChance * 10))){
                        print("\t\(hero) loses \(attack) ❤️")
                        hero.hitPoints -= attack
                    } else{
                        print("\t\(hero) is blocking the attack... no damage dealt")
                    }
                }
                
                pressEnterToContinue()
                isHeroesTurn = true
                turn = 1
                // reset the num of turns for thief
                hero.numOfTurns = maxTurns
            }
            
            // check if end of game
            if(hero.hitPoints <= 0){
                print("\(hero) is defeated by \(monster), you lose :(")
                gameOver = true
            } else if(monster.hitPoints <= 0){
                print("\(hero) defeats \(monster)!! You win 🎉")
                gameOver = true
            }
        }
        print("Would you like to play again? (y/n) ", terminator: "")
        let inputOp = readLine()
        if let input = inputOp{
            if(input.lowercased() == "y" || input.lowercased() == "yes"){
                isHeroesTurn = true
                turn = 1
                print("\n")
                playGame()
            } else{
                print("Thank you for playing :)\n")
            }
        }
    }
    
    // get input from the user
    func getInput() -> Int{
        print("--> ", terminator: "")
        let option = readLine()
        if let input = option{
            let inputInt: Int = Int(input)!
            if(inputInt == 1 || inputInt == 2 || inputInt == 3){
                return inputInt
            }
        }
        print("Invalid input, try again")
        return getInput()
    }
    
    // prints the attack menu to the user
    func printMenu() {
        print("\tPlease choose your attack from the following menu:")
        print("\t\t1) Normal attack")
        print("\t\t2) Special attack")
        print("\t\t3) Quit game")
    }
    
    // ask the user to resume the game
    func pressEnterToContinue(){
        print("Press enter to continue...")
        let _ = readLine()
        print()
    }
    
    // try to heal the monster
    func healMonster(){
        if(monster.hitPoints > 0){
            monster.hitPoints += monster.heal()
        }
    }
}
