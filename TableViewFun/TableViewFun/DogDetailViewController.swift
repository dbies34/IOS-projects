//
//  DogDetailViewController.swift
//  TableViewFun
//
//  Created by Drew Bies on 10/28/20.
//

import UIKit

class DogDetailViewController: UIViewController {

    var dogOptional: Dog? = nil
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var breedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let name = nameTextField.text, let breed = breedTextField.text {
                    if let dog = dogOptional {
                        dog.name = name
                        dog.breed = breed
                    }
                }
            }
        }
    }
    

}
