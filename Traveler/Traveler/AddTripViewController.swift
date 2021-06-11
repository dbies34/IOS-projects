//
//  AddTripViewController.swift
//  Traveler
//
//  Created by Drew Bies on 10/30/20.
//

import UIKit

class AddTripViewController: UIViewController, UITextFieldDelegate,  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var tripOptional: Trip? = nil
    var tripNumberStr = ""
    let dateFormatter = DateFormatter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var imageName: String? = nil
    
    @IBOutlet weak var tripNumberLabel: UILabel!
    @IBOutlet weak var destinationName: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        destinationName.delegate = self
        startDate.delegate = self
        startDate.delegate = self
        tripNumberLabel.text = tripNumberStr
        
        // setup the keyboard for the dates
        startDate.keyboardType = .numbersAndPunctuation
        startDate.autocorrectionType = .no
        endDate.keyboardType = .numbersAndPunctuation
        startDate.autocorrectionType = .no
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                print("save unwind segue")
                if let dest = destinationName.text, let startDateStr = startDate.text, let endDateStr = endDate.text {
                    
                    // create new trip
                    let startDate = dateFormatter.date(from: startDateStr)!
                    let endDate = dateFormatter.date(from: endDateStr)!
                    
                    let newTrip = Trip(context: self.context)
                    newTrip.destinationName = dest
                    newTrip.startDate = startDate
                    newTrip.endDate = endDate
                    newTrip.imageFileName = imageName
                    tripOptional = newTrip
                }
            }
        }
    }
    
    // lets the user pick a photo from their library or take one using the camera
    @IBAction func photoButtonPressed(_ sender: UIButton){
        print("pick photo button pressed")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // show camera option if user has a camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        // show photo library option if user has a photo library
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
                action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    // get the image that the user selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        writeImage(imageOptional: selectedImage)
        dismiss(animated: true, completion: nil)
    }
    
    // save the user’s trip image as a JPEG file
    func writeImage(imageOptional: UIImage?){
        // user UUID to name the image file and add .jpeg
        if let image = imageOptional {
            let imageName = UUID().uuidString
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let imagePath = paths[0].appendingPathComponent(imageName)
            
            if let jpegData = image.jpegData(compressionQuality: 0.8){
                try? jpegData.write(to: imagePath)
            }

            self.imageName = imagePath.path
        }
    }
    
    // check the user input
    // if missing or invalid, tell user and cancel segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let alertCon = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertCon.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if identifier == "SaveUnwindSegue"{
            if destinationName.text == "" {
                alertCon.title = "Missing Destination"
                alertCon.message = "Please enter the name of your destination"
                present(alertCon, animated: true, completion: nil)
                return false
            } else if startDate.text == "" || endDate.text == "" {
                alertCon.title = "Missing Date"
                alertCon.message = "Please enter the date of your trip"
                present(alertCon, animated: true, completion: nil)
                return false
            } else if dateFormatter.date(from: startDate.text!) == nil || dateFormatter.date(from: endDate.text!) == nil {
                alertCon.title = "Invalid Date"
                alertCon.message = "Please enter in a valid date"
                present(alertCon, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    // remove keyboard when user clicks outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // assign the first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
