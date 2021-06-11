//
//  UnoGame.swift
//  PA2-Uno
//
//  Created by Drew Bies on 9/16/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

class UnoGame{
    var deck = Deck()
    var player1 = Player(isPlayer1: true)
    var com = Player(isPlayer1: false)
    var isPlayer1Turn = true
    var skipTurn = false
    
    // play the game
    func playGame(){
        var isGameOver = false
        printIntructions()
        // decide who goes first
        let randNum = arc4random_uniform(2)
        if(randNum > 0){
            isPlayer1Turn = false
            print("The computer is going first.")
        } else{
            print("Player 1 (user) is going first.")
        }
        
        // fill the players' hands
        for _ in 0..<7{
            player1.drawCard(card: deck.draw())
            com.drawCard(card: deck.draw())
        }
        
        // run game loop
        while(!isGameOver){
            if(isPlayer1Turn){
                print("‼️ Player 1's turn ‼️")
            } else{
                print("‼️ Computer's turn ‼️")
            }
            print(deck)
            
            if(isPlayer1Turn){
                // user's turn
                if(!skipTurn){
                    if(deck.currentCard.name == "draw2"){
                        player1.drawCard(card: deck.draw())
                        player1.drawCard(card: deck.draw())
                    }
                    print("Your hand: \(player1)")
                    while(!canPlay(player: player1)){
                        player1.drawCard(card: deck.draw())
                        print("\tYou cannot play so you draw a card")
                        print("Your hand: \(player1)")
                    }
                    deck.discard(card: player1.playCard(at: getUserInput()))
                    print("\tYou play \(deck.currentCard)")
                    skipTurn = (deck.currentCard.name == "skip")
                } else{
                    print("\tSorry your turn was skipped.")
                    skipTurn = false
                }
            }else{
                // computer's turn
                if(!skipTurn){
                    if(deck.currentCard.name == "draw2"){
                        com.drawCard(card: deck.draw())
                        com.drawCard(card: deck.draw())
                    }
                    print("Opponent's hand: \(com)")
                    while(getSuggestedIndex() == -1){
                        com.drawCard(card: deck.draw())
                        print("\tComputer draws a card.")
                        print("Opponent's hand: \(com)")
                    }
                    deck.discard(card: com.playCard(at: getSuggestedIndex()))
                    print("\tThe computer plays \(deck.currentCard)")
                    skipTurn = (deck.currentCard.name == "skip")
                }else{
                    print("\tThe computer loses their turn.")
                    skipTurn = false
                }
            }
            // check for end of game
            if(player1.hand.numCards == 0 || com.hand.numCards == 0){
                isGameOver = true
                print("Game over!")
            }
            isPlayer1Turn.toggle()
            print()
            // check if the draw pile is empty
            if(deck.drawPile.isEmpty){
                deck.emptyDiscardPile()
            }
        }
        // check who won
        if(player1.hand.numCards == 0){
            print("🎉🎉 Congrats!! You win 🎉🎉")
        } else{
            print("🙁 Sorry you lose 🙁")
        }
    }
    
    // return index for the suggested computer card to play
    func getSuggestedIndex() -> Int{
        for i in 0..<com.hand.numCards{
            let card = com.getCard(index: i)
            if(card.color == deck.currentCard.color || card.name == deck.currentCard.name){
                return i
            }
        }
        return -1
    }
    
    // get what card to play from user
    func getUserInput() -> Int{
        print("Please enter the 0-based index of the card you wish to play: ", terminator: "")
        let input = readLine()
        if let inputInt = input{
            let num = Int(inputInt)!
            if(num >= 0 && num < player1.hand.numCards){
                let card = player1.getCard(index: num)
                if(card.color == deck.currentCard.color || card.name == deck.currentCard.name){
                    return num
                }
            }
        } 
        print("🚫 Invalid input, try again 🚫")
        return getUserInput()
    }
    
    // returns true if the player has a card they can play
    func canPlay(player: Player) -> Bool{
        for i in 0..<player.hand.numCards{
            let card = player.getCard(index: i)
            if(card.color == deck.currentCard.color || card.name == deck.currentCard.name){
                return true
            }
        }
        return false
    }
    
    // prints the instructions to the screen
    func printIntructions(){
        print("❕Uno Instructions ❕")
        print("To play a card you must match either the color or name of the current card.")
        print("Each card in your hand as an index and that must be entered to play the card.")
        print("ex. 0-🔴8🔴, 1-🔴3🔴 to play the red three you must enter 1")
        print("The skip card skips the opponent's turn and the draw2 makes the opponent draw 2 cards.")
        print("The player that has zero cards in their hand wins the game. Good luck!")
        print()
    }
}
