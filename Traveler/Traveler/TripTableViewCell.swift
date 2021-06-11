//
//  TripTableViewCell.swift
//  Traveler
//
//  Created by Drew Bies on 11/4/20.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var tripImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // update the cell with trip
    func update(with trip: Trip){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        // let todayStr = dateFormatter.string(from: today)
        locationLabel.text = trip.destinationName
        
        guard let startDate = trip.startDate as Date?, let endDate = trip.endDate as Date? else {
            print("Error could not unwrap dates")
            return
        }
        let startDateStr = dateFormatter.string(from: startDate)
        let endDateStr = dateFormatter.string(from: endDate)
        dateLabel.text = "\(startDateStr) - \(endDateStr)"
    
        
        if let image = trip.imageFileName{
            tripImage.image = UIImage(named: image)
        }
    }

}
