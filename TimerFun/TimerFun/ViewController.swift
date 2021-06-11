//
//  ViewController.swift
//  TimerFun
//
//  Created by Drew Bies on 10/5/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textTime: UILabel!
    
    var seconds: Int = 0 {
        didSet {
            textTime.text = "\(seconds)"
        }
    }
    
    // MARK: - Timer
    // use a timer to exectute code later... perhaps periodically (after some timer has passed)
    // 2 types of Timers
    // 1. non-repeating
    // 2. repeating
    // call invalidate() to stop a repeating timer
    var timer: Timer? = nil
    // task: add a seconds property (Int) with a property observer to update the secondsLabel
    // task: invalidate and set timer to nil
    // on pause and reset (something else)
    
    // start the timer
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.seconds += 1
            // recall: that closures "capture" their external references
            //
        })
    }
    
    // pause the timer by deleting it
    func pauseTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    // set the timer to 0
    func resetTimer(){
        self.seconds = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // start the timer
    @IBAction func startBtn(_ sender: UIButton) {
        //print("hello from start")
        if timer == nil{
            startTimer()
        }
        
    }
    
    // pause the timer
    @IBAction func pauseBtn(_ sender: UIButton) {
        pauseTimer()
    }
    
    // pause and set the timer to 0
    @IBAction func resetBtn(_ sender: UIButton) {
        pauseTimer()
        resetTimer()
    }
    
    
}

