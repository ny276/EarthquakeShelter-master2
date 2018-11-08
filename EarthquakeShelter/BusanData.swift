//
//  BusanData.swift
//  EarthquakeShelter
//
//  Created by D7703_18 on 2018. 11. 6..
//  Copyright © 2018년 201550057. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class BusanData: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(subtitle)"
        
        return mapItem
    }
}
