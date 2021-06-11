//
//  main.swift
//  PA2-Uno
//
//  Created by Drew Bies on 9/16/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

var newGame = UnoGame()
newGame.playGame()


// helpful tips for OOP problem/solution:
// 1. familiarize yourself with the *problem*
// e.g. read the rules, play the game
// 2. identify the nouns in the problem
// e.g. cards, deck (discard pile, draw pile), players (players have hands)
// 3. identify the verbs in the problem
// how do the nouns interact with each other and the user
// e.g. a player draws a card, a deck (draw pile) deals a hand of 7 cards to a player
// 4. model your nouns as types (classes, structs, enums)
// and model your verbs as methods

// start with the fundamental unit of your problem (cards)
