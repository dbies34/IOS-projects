//
//  TripTableViewController.swift
//  Traveler
//
//  Created by Drew Bies on 10/30/20.
//

import UIKit
import CoreData

class TripTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var trips = [Trip]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectoryURL)
        
        loadTrips()
    }
    
    // MARK: - Navigation

    // send trip information for detail and add trip view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                print("detail segue")
                if let tripDetailVC = segue.destination as? TripDetailViewController {
                    // we need to get the indexPath for the row the user clicked on
                    // we need to get the dog at the row
                    // pass the dog into detailDetailVC
                    if let indexPath = tableView.indexPathForSelectedRow {
                        tripDetailVC.tripNumberStr = "Trip \(indexPath.row + 1) of \(trips.count)"
                        let trip = trips[indexPath.row]
                        tripDetailVC.tripOptional = trip
                    }
                }
            }
            else if identifier == "AddSegue" {
                print("add segue")
                if let addTripVC = segue.destination as? AddTripViewController{
                    if let indexPath = tableView.indexPathForSelectedRow {
                        addTripVC.tripNumberStr = "Add Trip #\(trips.count + 1)"
                        addTripVC.tripOptional = trips[indexPath.row]
                        print("adding \(trips[indexPath.row])")
                    }
                }
            }
        }
    }
    
    // keep track of the row number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return trips.count
        }
        return 0
    }
        
    // allow the cells to be moved
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let trip = trips[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
        
        cell.update(with: trip)
        // allow the cells to be reordered
        cell.showsReorderControl = true
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    
    // allow the cell to be inserted back after reordering
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let trip = trips.remove(at: sourceIndexPath.row)
        trips.insert(trip, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    // toggle editing mode when edit button is pressed
    @IBAction func editPressed(_ sender: UIBarButtonItem){
        let newEditingMode = !tableView.isEditing
        tableView.setEditing(newEditingMode, animated: true)
    }
    
    // handling for a deleted trip
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let imageFilePath = trips[indexPath.row].imageFileName{
                let fileManager = FileManager.default
                
                do {
                    if fileManager.fileExists(atPath: imageFilePath){
                        try fileManager.removeItem(atPath: imageFilePath)
                    } else{
                        print("Error file does not exist")
                    }
                } catch {
                    print("Error could not delete photo file")
                }
                
            }
            
            // delete trip from db
            context.delete(trips[indexPath.row])
            // remove trip from the UI
            trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // save the changes to the db
            saveTrips()
        }
    }
    
    // unwind from add trip and add the new trip if they press save
    @IBAction func unwindToTripTableViewController(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                print("save trip")
                if let addTripVC = segue.source as? AddTripViewController {
                    if let trip = addTripVC.tripOptional {
                        
                        // add new trip to db from addNewTripController
                        self.trips.append(trip)
                        self.saveTrips()
                        
                        // force update the table view
                        tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // save the trips to the core data
    func saveTrips(){
        do {
            try context.save()
        } catch  {
            print("Error saving categories \(error)")
        }
        tableView.reloadData()
    }
    
    // load the trips from the core data
    func loadTrips(){
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try context.fetch(request)
        } catch  {
            print("Error loading trips \(error)")
        }
        tableView.reloadData()
    }
}
