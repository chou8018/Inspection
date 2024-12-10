//
//  LocationManager.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 11/10/2564 BE.
//

import Foundation
import CoreLocation

class LocationManager : NSObject {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion: ((String?,CLLocation)-> Void)?
    
    public func getLocationName(completion: @escaping ((String?,CLLocation)-> Void)){
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    fileprivate func resolveLocationName(with location: CLLocation){
        let geocoder = CLGeocoder()
        //13.719258, 100.703405 Bangkok
        //16.818049, 100.265804 Phitsanulok
        //9.140169, 99.330835  Surat Thani
        //14.973017, 102.079469 Nakhon Ratchasima
        //13.230265, 101.135093 Chonburi
        //18.794636, 98.984649 Chiang Mai
        //15.693986, 100.108185 Nakhon Sawan
        //13.812458, 100.032244 Nakhon Pathom
        //14.548824, 100.915497 Saraburi
        //7.008238, 100.474262 Songkhla  <- HatYai

        
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) {[weak self] placeMark, error in
            guard let weakself = self else { return }
            guard let place = placeMark?.first, error == nil else {
                weakself.completion?(nil, location)
                return
            }
            var name = ""
//            if let locality = place.locality {
//                name += locality
//            }
            if let administrativeArea = place.administrativeArea {
                name += "\(administrativeArea)"
            }
            weakself.completion?(name, location)
        }
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        resolveLocationName(with: location)
        manager.stopUpdatingLocation()
    }
    
    
}
