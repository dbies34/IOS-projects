//
//  ViewController.swift
//  AlertFunS1
//
//  Created by Drew Bies on 9/28/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    
    @IBAction func echoBackPressed(_ sender: UIButton) {
        if let text = textField.text{
            print(text)
            // MARK: - Alerts
            // there are two types of alerts
            // actionSheet: show to the user when they expect some user input (e.g. delete some values and you want to confirm the delete)
            // alert: show to the user when something goes wrong and they dont expect user input/message
            // use a UIAlertController to set up our alert
            let alertController = UIAlertController(title: "Echo Back", message: text, preferredStyle: .actionSheet)
            // lets add a UIAlertAction to our alert dialog
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: {
                (action) -> Void in
                print("user pressed ok")
            }))
            // show the alert with present()
            present(alertController, animated: true, completion: {
                //(action) -> Void in
                print("user saw the alert")
            })
        }
    }
    // task: IB, add a UITextField that is as wide as the iPhone SE screen
    // ignore any runtime warnings...
    // add a Button underneath the TextField that says "Echo Back"
    // wire up the connections for an IBOutlet and IBAction

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

