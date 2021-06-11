//
//  ViewController.swift
//  Carpet Fishing
//
//  Created by Drew Bies on 10/12/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    let carpetSea = CarpetSea()
    var timer: Timer? = nil
    var isLineIn = false
    var placedFish = false
    var isPaused = false
    
    // keep track of points and update the score label
    var points = 0 {
        didSet{
            scoreLabel.text = "Score: \(points)"
        }
    }
    
    // keep track of seconds and update the time label
    var seconds = 0 {
        didSet{
            timeLabel.text = "Time: \(seconds)"
        }
    }
    
    
    // make the instructions be the first thing the user sees
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInstructions()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // new game button
    @IBAction func newGamePressed(_ sender: UIButton) {
        print("start new game")
        
        let alert = UIAlertController(title: "New Game?", message: "Starting a new game will reset your score and the time.", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.initGame()})
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // drops the fishing line on the button the user clicks
    @IBAction func buttonPressed(_ sender: UIButton){
        
        isLineIn = true
        switch sender.tag {
        case 0:
            carpetSea.dropFishingLine(row: 0, col: 0)
        case 1:
            carpetSea.dropFishingLine(row: 0, col: 1)
        case 2:
            carpetSea.dropFishingLine(row: 1, col: 0)
        case 3:
            carpetSea.dropFishingLine(row: 1, col: 1)
        default: break
        }
        
        // disable all the buttons and show the fish under them
        for btn in buttons{
            btn.backgroundColor = UIColor.lightGray
            btn.isEnabled = false
            switch btn.tag {
            case 0:
                btn.setTitle(carpetSea.grid[0][0].fish, for: .normal)
            case 1:
                btn.setTitle(carpetSea.grid[0][1].fish, for: .normal)
            case 2:
                btn.setTitle(carpetSea.grid[1][0].fish, for: .normal)
            case 3:
                btn.setTitle(carpetSea.grid[1][1].fish, for: .normal)
            default: break
            }
        }
    }
    
    // reels in the line and tells the user what they caught
    func reelInLine(){
        let fishCaught = carpetSea.checkFishCaught()
        var alertTitle = ""
        var msg = ""
        if(fishCaught != nil){
            alertTitle = "Nice job!!"
            let fish: String = fishCaught!
            let pts: Int = carpetSea.availableFish[fish]!
            msg = "You caught a \(fish)! That's worth \(pts) points!"
            points += pts
        } else{
            alertTitle = "Too bad :("
            msg = "Sorry you didn't catch anything."
        }
        
        let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
        
        // enable all the buttons
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: {
            (action) -> Void in self.enableButtons()
        })
        isLineIn = false
        carpetSea.resetGrid()
        carpetSea.randomlyPlaceFish()
        print(carpetSea)
        alert.addAction(continueAction)
        present(alert, animated: true, completion: nil)
    }
    
    // reset the buttons and enable them
    func enableButtons(){
        for btn in self.buttons{
            btn.isEnabled = true
            btn.setTitle("", for: .normal)
            btn.backgroundColor = UIColor.systemTeal
        }
    }
    
    // initialize and start the game
    func initGame(){
        points = 0
        seconds = carpetSea.S
        timer?.invalidate()
        timer = nil
        enableButtons()
        startTimer()
    }
    
    
    // show the instructions to the user
    func showInstructions(){
        var availableFish = ""
        // sort the fish by their points
        let sortedFish = carpetSea.availableFish.sorted {$0.1 < $1.1}
        for (fish, points) in sortedFish{
            availableFish.append("\(fish) is worth \(points) points\n")
        }
        
        let msg = "Carpet Fishing Rules:\nThe game revolves around pressing one of the carpet squares to drop a fishing line. If you are lucky, the square will contain a fish and reward you with points! The scoring goes as follows:\n\n\(availableFish)\nThe game is over once the timer runs out.\nGood Fishing!"
        
        let alert = UIAlertController(title: "Welcome to Carpet Fishing!", message: msg, preferredStyle: .alert)
        
        // add okay and exit to the alert
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: {(action) -> Void in self.initGame()})
        let exitAction = UIAlertAction(title: "Exit", style: .cancel, handler: {(action) -> Void in exit(0)})
        
        alert.addAction(okAction)
        alert.addAction(exitAction)
        
        // alert the user with the instructions
        present(alert, animated: true, completion: nil)
    }
    
    // start the timer with S seconds and count down
    // reel in the line every second if the line is down
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            (timer) -> Void in
            self.seconds -= 1
            
            // check for game over condition
            if(self.seconds <= 0){
                self.gameOver()
            }
            
            if(self.isLineIn){
                self.reelInLine()
            }
        })
    }
    
    // alert the user with their score when the time is up and allow them to play again
    func gameOver(){
        // stop the timer
        timer?.invalidate()
        timer = nil
        let alert = UIAlertController(title: "Time is up!!", message: "Congrats you scored \(points) points in \(carpetSea.S) seconds! Would you like to play again?", preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "No thanks", style: .cancel, handler: {(action) -> Void in exit(0)})
        let yesAction = UIAlertAction(title: "Yes!", style: .default, handler: {(action) -> Void in self.initGame()})
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
}

