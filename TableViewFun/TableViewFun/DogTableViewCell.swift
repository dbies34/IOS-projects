//
//  DogTableViewCell.swift
//  TableViewFun
//
//  Created by Drew Bies on 10/23/20.
//

import UIKit

class DogTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var breedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with dog: Dog){
        nameLabel.text = dog.name
        breedLabel.text = dog.breed
    }

}
