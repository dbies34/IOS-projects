//
//  Hand.swift
//  PA2-Uno
//
//  Created by Drew Bies on 9/16/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

class Hand: CustomStringConvertible{
    var cards: [Card] = []
    var numCards: Int = 0
    var description: String{
        var desc = ""
        for i in 0..<numCards{
            desc.append("\(i)-\(cards[i].description)")
            if(i != numCards - 1){
                desc.append(", ")
            }
        }
        return desc
    }
    var secretDescription: String{
        var secret = ""
        for i in 0..<numCards{
            secret.append(cards[i].secretDescription)
            if(i != numCards - 1){
                secret.append(", ")
            }
        }
        return secret
    }
    
    // get card at index
    func getCard(index: Int) -> Card{
        return cards[index]
    }
    
    // get card at index and remove it
    func removeCard(index: Int) -> Card{
        numCards -= 1
        return cards.remove(at: index)
    }
    
    // add card to hand
    func addCard(card: Card){
        numCards += 1
        cards.append(card)
    }
}
