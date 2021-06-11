//
//  ViewController.swift
//  CoreLocationFunS1
//
//  Created by Drew Bies on 11/18/20.
//

import UIKit
import CoreLocation

// MARK: - Location Services
// Simulator -> Features -> Location
// set a predefined location, route or a custom location
// CLLocationManager: a class used to get the user's location and updates
// GLGeocoder: a class used to convert address/place -> coordinates and coordinates -> address/place
// task: set up a UI with three labels: latitude, longitide, name
// set up the outlets as well

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // first make sure location services are enabled
        if CLLocationManager.locationServicesEnabled() {
            print("enabled")
            setupLocationServices()
        }
        else {
            print("disabled")
        }
    }
    
    func setupLocationServices(){
        // we need a CLLocationManager object
        // and we need to setup a delegate for it
        locationManager.delegate = self
        
        // we need to request authorization from the user to get their location
        // 2 types of location authorization
        // 1. when in use: the app can get location updates when it is running
        // 2. always: the app always gets location updates. the OS will start your app to deliver an update
        // we are going with 1
        // we need to add a key-value pair to our Info.plist to declare the authorization
        // key: Privacy - Location when in use
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // two types of location updates
        // 1. requestLocation(): one time update of the user's location
        // 2. startUpdatingLocation(): continous updates based on the desiredAccuracy
        // for #2, dont forget to call stopUpdatingLocation() when youre done with location updates
        locationManager.requestLocation()
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let location = locations[locations.count - 1]
        // update the labels
        latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"
        // get the name of the current location using a geocoder
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placeMarksOptional, errorOptional) in
            if let placeMarks = placeMarksOptional, placeMarks.count > 0 {
                let placeMark = placeMarks[0]
                if let name = placeMark.name {
                    self.nameLabel.text = "Name: \(name)"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error accessing location \(error)")
        // here are a few noteworthy error codes
        // 0: no location (e.g. Simulator location set to none)
        // 1: authorization deny
    }

}

