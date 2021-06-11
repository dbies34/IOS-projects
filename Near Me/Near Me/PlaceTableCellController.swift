//
//  PlaceTableCellController.swift
//  Near Me
//
//  Created by Drew Bies on 12/6/20.
//

import Foundation
import UIKit

class PlaceTableCellController: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // update the cell with the place name, rating, and address
    func update(with place: Place){
        titleLabel.text = "\(place.name) (\(place.rating)⭐️)"
        subtitleLabel.text = place.vicinity
    }
}
