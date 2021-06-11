//
//  main.swift
//  hangmanPA1
//
//  Created by Drew Bies on 9/11/20.
//  Copyright © 2020 Drew Bies. All rights reserved.
//

import Foundation

// contains the words to guess
var words: [String] = ["sprint", "zags", "bulldog", "spike", "basketball", "golf", "smoke", "summer",  "gina", "spokane"]
// contains the letters not guessed yet
var availableLetters: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
// contains the letters guessed correctly
var visibleLetters: [Character] = []

var wordToGuess = ""

var guessesLeft = 7

var gameOver = false
fillWordsArray()

initGame()

print("The word to guess has \(wordToGuess.count) letters.\n")

// game loop
while(!gameOver){
    printVisibleLetters()
    printAvailableLetters()
    print("\(guessesLeft) incorrect guesses remaining.")
    let letter = getLetter()
    
    // find and remove the guessed letter from the available letters
    if(availableLetters.contains(letter)){
        for i in 0..<availableLetters.count{
            if(availableLetters[i] == letter){
                availableLetters.remove(at: i)
                break
            }
        }
    }
    
    // add the correctly guessed letter to the visible letters
    if(wordToGuess.contains(letter)){
        print("Nice! \(letter) is in the word.")
        for i in 0..<visibleLetters.count{
            if(wordToGuess[wordToGuess.index(wordToGuess.startIndex, offsetBy: i)] == letter){
                visibleLetters[i] = letter
            }
        }
    }
    else{
        print("That's too bad! \(letter) is not in the word.")
        guessesLeft -= 1
    }
    // check if game is over
    if(guessesLeft == 0 ){
        print("Sorry you lost :(", terminator: " ")
        gameOver = true
    }
    else if(String(visibleLetters) == wordToGuess){
        print("Congrats! You win :)", terminator: " ")
        gameOver = true
    }
    
}
print("The word was \(wordToGuess).")

// initialize the game by picking the word and filling the visible letters with dashes
func initGame(){
    let randNum = arc4random_uniform(UInt32(words.count))
    wordToGuess = words[Int(randNum)]
    for _ in 0..<wordToGuess.count {
        visibleLetters.append("-")
    }
}

// print the visible letters to the user
func printVisibleLetters(){
    for i in 0..<visibleLetters.count{
        print(visibleLetters[i], terminator: " ")
    }
    print()
}

// print the available letters to the user
func printAvailableLetters(){
    print("Available letters: ", terminator: "")
    for i in 0..<availableLetters.count{
        print(availableLetters[i], terminator: "")
    }
    print()
}

// get the guessed letter from the user
func getLetter() -> Character{
    print("Please enter your guess: ", terminator: "")
    let letterOptional = readLine()
    if let letter = letterOptional{
        if(letter.count == 1){
            print()
            return Character(letter)
        }
    }
    return getLetter()
}

func fillWordsArray(){
    let home = FileManager.default.homeDirectoryForCurrentUser
    let fileURL = home.appendingPathComponent("Desktop").appendingPathComponent("words").appendingPathExtension("txt")
    let fileManager = FileManager.default
    if(!fileManager.fileExists(atPath: fileURL.path)){
        print("Error: file could not be found. Using preloaded words.")
    }

    do {
        let text = try String(contentsOf: fileURL, encoding: .utf8)
        var textArray: [String] = text.components(separatedBy: "\n")
        textArray.remove(at: textArray.endIndex - 1)
        for i in 0..<textArray.count{
            words[i] = textArray[i]
        }
    }
    catch {
        print("Error: could not read file. Using preloaded words.")
    }
    
}
