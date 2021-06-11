//
//  PlacesAPI.swift
//  Near Me
//
//  Created by Drew Bies on 12/6/20.
//

import Foundation
import UIKit

class PlacesAPI {
    static let API_KEY = "XXXXXXXXXXXXXXXXXXXXXXX"
    
    // return a url that is used to get the places nearby json
    static func findNearbyPlacesUrl(latitude: Double, longitude: Double, keyword: String) -> URL{
        let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        
        let parmas = [
            "key" : PlacesAPI.API_KEY,
            "location" : "\(latitude),\(longitude)",
            "keyword": keyword,
            "rankby" : "distance"
        ]
        
        // turn the params into queryItem format for the URL
        var queryItems = [URLQueryItem]()
        for(key, value) in parmas {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        var components = URLComponents(string: baseUrl)!
        components.queryItems = queryItems
        let url = components.url!
        //print(url)
        return url
    }
    
    // fetch places nearby using the places url
    static func fetchPlacesNearby(latitude: Double, longitude: Double, keyword: String, completion: @escaping ([Place]?) -> Void){
        let url = PlacesAPI.findNearbyPlacesUrl(latitude: latitude, longitude: longitude, keyword: keyword)
        let task = URLSession.shared.dataTask(with: url) { (dataOptional, urlResponseOptional, errorOptional) in
            
            if let data = dataOptional {
                // parse the Data response into json
                
                if let places = places(fromData: data) {
                    print("we got \(places.count) places")

                    DispatchQueue.main.async {
                        completion(places)
                    }
                }
                else{
                    // failure
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            else {
                if let error = errorOptional {
                    print("Error getting the Data \(error)")
                }
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    // parse the places json into a Place array
    static func places(fromData data: Data) -> [Place]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDictionary = jsonObject as? [String: Any], let results = jsonDictionary["results"] as? [[String: Any]] else {
                print("Error parsing JSON")
                return nil
            }
            print("got results")
            var places = [Place]()
            for placeObject in results {
                // parse json into places array
                if let place = place(fromJSON: placeObject){
                    places.append(place)
                }
            }
            
            if !places.isEmpty {
                return places
            }
        }
        catch {
            print("Error converting Data to JSON \(error)")
        }
        return nil
    }
    
    // return Place object from the place json
    static func place(fromJSON json: [String: Any]) -> Place? {
        // parse the important info from the json
        guard let name = json["name"] as? String, let id = json["place_id"] as? String, let vicinity = json["vicinity"] as? String, let rating = json["rating"] as? Double, let photos = json["photos"] as? [[String: Any]], let photo = photos[0] as? [String: Any], let photoRef = photo["photo_reference"] as? String, let openingHours = json["opening_hours"] as? [String: Any], let isOpen = openingHours["open_now"] as? Bool else {
            //print("error converting json to place type")
            return nil
        }
        // return the data as a Place type
        return Place(id: id, name: name, vicinity: vicinity, rating: rating, isOpen: isOpen, photoReference: photoRef)
    }
    
    // fetch the place photo using the photo reference
    static func fetchImage(fromPhotoRef refString: String, completion: @escaping (UIImage?) -> Void){
        let maxHeight = 200
        let maxWidth = 200
        let urlStr = "https://maps.googleapis.com/maps/api/place/photo?maxheight=\(maxHeight)&maxwidth=\(maxWidth)&photoreference=\(refString)&key=\(API_KEY)"
        let url = URL(string: urlStr)!
        
        let task = URLSession.shared.dataTask(with: url){ (dataOptional, urlResponseOptional, errorOptional) in
            if let data = dataOptional, let image = UIImage(data: data){
                // task: call completion, pass in the image
                // update the UIImageView :)
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            else {
                if let error = errorOptional {
                    print("Error fetching image \(error)")
                }
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    // fetch place details using the place id
    static func fetchPlaceDetails(fromId id: String, completion: @escaping (Dictionary<String, String>?) -> Void){
        let urlStr = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(id)&fields=formatted_phone_number,reviews&key=\(API_KEY)"
        let url = URL(string: urlStr)!
        let task = URLSession.shared.dataTask(with: url){ (dataOptional, urlResponseOptional, errorOptional) in
            if let data = dataOptional {
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let jsonDictionary = jsonObject as? [String: Any], let results = jsonDictionary["result"] as? [String: Any], let phoneNumber = results["formatted_phone_number"] as? String, let reviews = results["reviews"] as? [[String: Any]], let review = reviews[0] as? [String: Any], let reviewStr = review["text"] as? String else {
                        print("error parsing place detail json")
                        return
                    }
                    // make the details dictionary
                    let details = [
                        "phone": phoneNumber,
                        "review": reviewStr
                    ]
                    
                    DispatchQueue.main.async {
                        completion(details)
                    }
                    
                } catch {
                    print("error converting to json \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            else {
                if let error = errorOptional {
                    print("error getting place details json \(error)")
                }
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
