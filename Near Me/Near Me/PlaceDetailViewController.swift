//
//  PlaceDetailViewController.swift
//  Near Me
//
//  Created by Drew Bies on 12/6/20.
//

import Foundation
import UIKit
import MBProgressHUD

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var place: Place? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayPlace()
    }
    
    // display the selected place to the user
    func displayPlace(){
        if let place = place{
            titleLabel.text = place.name
            addressLabel.text = place.vicinity
            if place.isOpen{
                openLabel.text = "(Open)"
            } else{
                openLabel.text = "(Closed)"
            }
            // show loading bar while waiting 
            MBProgressHUD.showAdded(to: self.view, animated: true)
            // fetch extra place details
            PlacesAPI.fetchPlaceDetails(fromId: place.id) { (detailsOptional) in
                if let details = detailsOptional{
                    self.phoneLabel.text = details["phone"]
                    self.reviewLabel.text = details["review"]
                }
            }
            
            // fetch photo
            PlacesAPI.fetchImage(fromPhotoRef: place.photoReference) { (imageOptional) in
                if let image = imageOptional{
                    self.imageView.image = image
                }
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
