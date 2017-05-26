//
//  MapViewController.swift
//  Stalker
//
//  Created by m2sar on 27/04/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var MapOutlet: MKMapView!
    
    let locationManager = CLLocationManager()
    var friends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        
        MapOutlet.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
        
        //ADD friends  pins
        for f in friends {
            let friendPin = Pin(coordinate: CLLocationCoordinate2D(latitude: (f.lastPosition?.latitude!)!, longitude: (f.lastPosition?.longitude!)!), title: f.name!)
            MapOutlet.addAnnotation(friendPin)
        }
        
        //know user location
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadFriends(){
        
        //TO MODIFY class USER
        let friend1 = User(name:"ally", lastPosition: Position(latitude: 48.846395, longitude: 2.356940))
        let friend2 = User(name: "bob", lastPosition: Position(latitude: 48.844793, longitude: 2.356940))
        let friend3 = User(name: "claude", lastPosition: Position(latitude: 48.844807, longitude: 2.354718))
        let friend4 = User(name: "eliott", lastPosition: Position(latitude: 48.845852, longitude: 2.354933))
        let friend5 = User(name: "fred", lastPosition: Position(latitude: 48.847666, longitude: 2.356778))
        
        
        friends += [friend1, friend2, friend3, friend4, friend5]
    }
    
    
}
