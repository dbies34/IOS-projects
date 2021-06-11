//
//  TripDetailViewController.swift
//  Traveler
//
//  Created by Drew Bies on 10/30/20.
//

import UIKit

class TripDetailViewController: UIViewController {
    
    var tripOptional: Trip? = nil
    var tripNumberStr = ""
    
    @IBOutlet weak var tripNumberLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var tripImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTrip()
        // update the trip number label
        tripNumberLabel.text = tripNumberStr
    }
    
    // display the trip information of the selected trip
    func displayTrip(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let trip = tripOptional{
            if let dest = trip.destinationName{
                destinationLabel.text = "Destination: \(dest)"
            }
            if let startDate = trip.startDate as Date? {
                startDateLabel.text = "Start Date: \(dateFormatter.string(from: startDate))"
            }
            if let endDate = trip.endDate as Date? {
                endDateLabel.text = "End Date: \(dateFormatter.string(from: endDate))"
            }
            
            if let image = trip.imageFileName{
                print("image name: \(image)")
                tripImage.image = UIImage(contentsOfFile: image)
            }
        }
        else{
            print("Error: cant find trip")
        }
    }
}
