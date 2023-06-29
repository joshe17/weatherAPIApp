//
//  LocationManager.swift
//  weather
//
//  Created by Joshua Ho on 6/27/23.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: UIViewController {
    var locationManager = CLLocationManager()
    var location: CLLocation?
    
    var lat: Double?
    var lon: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        
        view.backgroundColor = .gray
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    // Setup Location Manager function
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    // Get user's GPS coordinates
    func getUserCoordinates() {
        // Implement network request passing in user's coordinates
        if let coordinates = locationManager.location?.coordinate{
            lat = coordinates.latitude
            lon = coordinates.longitude
        } else {
            print("Unable to get coordinates")
        }
    }
    
    // Check for GPS permission authorization
    func checkLocationAuthorization(){
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            // do GPS location stuff
            getUserCoordinates()
            locationManager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:
            getUserCoordinates()
            locationManager.startUpdatingLocation()
        case .denied:
            // Show an alert instructing user how to turn on permission
            break
        case.notDetermined:
            //            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            break
        case .restricted:
            // Show an alert instructing user how to turn on permission
            break
        default:
            break
        }
    }
    
    // Method to trigger when user's location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get latest location
        checkLocationAuthorization()
        
        // update location when user has moved
        
    }
    
    // Method to trigger when GPS location permission changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
}
