//
//  ViewController.swift
//  PA4tipCalculator
//
//  Created by Drew Bies on 10/3/20.
//

import UIKit

class ViewController: UIViewController {
    var billAmount: Double = 0.0
    var tipPercent: Double = 0.0
    
    // user inputs
    @IBOutlet var textBillAmount: UITextField!
    @IBOutlet var textTipPercent: UITextField!
    
    // outputs to the user
    @IBOutlet var textTipAmount: UITextField!
    @IBOutlet var textTotalBill: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textTipAmount.isUserInteractionEnabled = false
        textTotalBill.isUserInteractionEnabled = false
    }

    // update the total bill when the bill amount is changed
    @IBAction func billAmountChanged(_ sender: UITextField) {
        updateBill()
    }
    
    // update the total bill when the tip percent is changed
    @IBAction func tipPercentChanged(_ sender: UITextField) {
        updateBill()
    }
    
    // updates the total bill and the tip amount
    func updateBill(){
        if(textBillAmount.text != "" && textTipPercent.text != ""){
            billAmount = getBillAmount()
            tipPercent = Double(getTipPercent())
            
        } else{
            billAmount = 0.0
            tipPercent = 0.0
        }
        let tipAmount = tipPercent * 0.01 * billAmount
        textTipAmount.text = "$" + String(format: "%.2f", tipAmount)
        textTotalBill.text = "$" + String(format: "%.2f", tipAmount + billAmount)
    }
    
    // gets the bill amount from the text field
    func getBillAmount() -> Double{
        guard let inputString = textBillAmount.text, let inputDouble = Double(inputString), inputDouble >= 0 else {
            alertUser(msg: "Bill amount must be a positive number")
            return 0
        }
        
        return inputDouble
    }
    
    // gets the tip percent from the text field
    func getTipPercent() -> Int{
        guard let inputString = textTipPercent.text, let inputInt = Int(inputString), inputInt >= 0 else {
            alertUser(msg: "Tip percent must be a positive integer")
            return 0
        }
        return inputInt
    }
    
    // alerts the user with an invalid input
    func alertUser(msg: String){
        let alertController = UIAlertController(title: "Invalid Input", message: msg, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
            (action) -> Void in
        }))
        
        present(alertController, animated: true, completion: nil)
    }
}

