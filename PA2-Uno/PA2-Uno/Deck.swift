//
//  Deck.swift
//  PA2-Uno
//
//  Created by Drew Bies on 9/16/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

class Deck: CustomStringConvertible{
    var drawPile: [Card] = []
    var discardPile: [Card] = []
    var currentCard: Card {
        return discardPile[discardPile.count - 1]
    }
    var description: String{
        return "Current card: \(currentCard)"
    }
    
    // fill draw pile and shuffle
    init(){
        let colors = [Color.red, Color.blue, Color.yellow, Color.green]
        for color in colors {
            for i in 0..<10{
                drawPile.append(Card(color: color, name: "\(i)"))
                if(i > 0){
                    drawPile.append(Card(color: color, name: "\(i)"))
                }
            }
            drawPile.append(Card(color: color, name: "skip"))
            drawPile.append(Card(color: color, name: "skip"))
            drawPile.append(Card(color: color, name: "draw2"))
            drawPile.append(Card(color: color, name: "draw2"))
        }
//        for _ in 0..<4 {
//            drawPile.append(Card(color: Color.wild, name: "wild"))
//        }
        drawPile.shuffle()
        while(drawPile[0].name == "wild"){
            drawPile.shuffle()
        }
        // turn the first card over
        discard(card: draw())
    }
    
    // remove card from card pile and return to caller
    func draw() -> Card{
        return drawPile.remove(at: drawPile.count - 1)
    }
    
    // add card to the discard pile
    func discard(card: Card){
        discardPile.append(card)
    }
    
    // put the discard pile into the draw pile and shuffle
    func emptyDiscardPile(){
        drawPile = discardPile
        discardPile.removeAll()
        drawPile.shuffle()
        while(drawPile[0].name == "wild"){
            drawPile.shuffle()
        }
        // turn the first card over
        discard(card: draw())
    }
}
