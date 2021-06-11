//
//  ViewController.swift
//  Near Me
//
//  Created by Drew Bies on 12/5/20.
//

import UIKit
import CoreLocation
import MBProgressHUD

// app icon from:
// https://www.iconfinder.com/search/?q=place&price=free


// PlaceTableViewController, renaming this causes bugs
class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let locationManager = CLLocationManager()
    
    var latitude: Double = 47.6670321
    var longitude: Double = -117.403623
    var keyword: String = ""
    
    var places = [Place]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    
    // update the users location when the refresh button is pressed
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        print("refresh button pressed")
        // update the user location
        locationManager.startUpdatingLocation()
    }
    
    // perform the place search
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print("search button pressed")
        if let text = searchBar.text {
            self.keyword = text
            // first clean the table
            places.removeAll()
            tableView.reloadData()
            // dont fetch places if there is no keyword
            if text != "" {
                // fetch places for the table
                fetchPlaces()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // first make sure location services are enabled
        if CLLocationManager.locationServicesEnabled() {
            print("enabled")
            // setup core location
            setupLocationServices()
        }
        else {
            print("disabled")
        }
    }
    
    // fetches places around the user with their location and a keyword
    func fetchPlaces(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        PlacesAPI.fetchPlacesNearby(latitude: latitude, longitude: longitude, keyword: keyword) { (placesOptional) in
            if let places = placesOptional{
                print("in view controller with places array")
                self.places = places
                self.tableView.reloadData()
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    // sets up the core location services and starts updating the location
    func setupLocationServices(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
        //locationManager.startUpdatingLocation()
    }

    // finds the longitude and latitude of the user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        
        let location = locations[locations.count - 1]
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
        
    }
    
    // handles the errors of core location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error accessing location \(error)")
        // here are a few noteworthy error codes
        // 0: no location (e.g. Simulator location set to none)
        // 1: authorization deny
    }
    
    // send place to PlaceTableCellController
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceTableCellController
        let place = places[indexPath.row]
        cell.update(with: place)
        return cell
    }
    
    // keep track of the row number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return places.count
        }
        return 0
    }
    
    // handles when the user pressed a cell
    // sends the place to the detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                print("going to place details")
                
                if let detailPlaceVC = segue.destination as? PlaceDetailViewController {
                    // send the selected place to the detail controller
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let place = places[indexPath.row]
                        detailPlaceVC.place = place
                    }
                }
            }
        }
    }
        
    // clear the table when the search bar is cleared
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty {
            print("search bar cleared")
            DispatchQueue.main.async {
                self.places.removeAll()
                self.tableView.reloadData()
            }
            
        }
    }
}
