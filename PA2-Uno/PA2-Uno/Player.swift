//
//  Player.swift
//  PA2-Uno
//
//  Created by Drew Bies on 9/16/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

class Player: CustomStringConvertible{
    var isPlayer1: Bool = true
    var hand: Hand = Hand()
    var description: String{
        if(isPlayer1){
            return hand.description
        }
        else{
            return hand.secretDescription 
        }
    }
    
    init(isPlayer1: Bool) {
        self.isPlayer1 = isPlayer1
    }
    
    // get card at index
    func getCard(index: Int) -> Card{
        return hand.getCard(index: index)
    }
    
    // get card and remove from player
    func playCard(at: Int) -> Card{
        return hand.removeCard(index: at)
    }
    
    // add card to player
    func drawCard(card: Card){
        hand.addCard(card: card)
    }
}
