//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pavel Kylitsky on 10/02/2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    private var completionHandler: ((Result<CLLocationCoordinate2D, Error>) -> Void)?

    override init() {
        super.init()
        print("init")
        locationManager.delegate = self

    }
    
    deinit {
        print("DEINIT")
    }

    func requestLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        self.completionHandler = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordinates = location.coordinate
            completionHandler?(.success(coordinates))
            completionHandler = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(.failure(error))
        completionHandler = nil
    }
    
    //Get city name
    func cityNameForCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                print("Reverse geocoding failed with error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil)
                return
            }
            
            if let city = placemark.locality {
                completion(city)
            } else {
                print("City name not found")
                completion(nil)
            }
        }
    }

}
