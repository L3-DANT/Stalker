//
//  MapViewController.swift
//  Stalker
//
//  Created by m2sar on 27/04/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var MapOutlet: MKMapView!
    
    let locationManager = CLLocationManager()
    var friends = [User]()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPins()
        
        // Ask for Authorisation from the User
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        MapOutlet.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadFriends() {
        FriendshipService.getAll(isAccepted: true, completion: { (inner: UsersBuilder) in
            do {
                self.friends = try inner()
                
                DispatchQueue.main.async {
                    self.view.reloadInputViews()
                }
            }
            catch let error {
                print(error)
            }
        })
    }
    
    private func loadPins() {
        if self.friends.count < 1 {
            self.loadFriends()
        }
        // Add friends pins
        for friend in self.friends {
            let coordinate = CLLocationCoordinate2D(latitude: (friend.lastPosition?.latitude)!, longitude: (friend.lastPosition?.longitude)!)
            let friendPin = Pin(coordinate: coordinate, title: friend.name!)
            MapOutlet.addAnnotation(friendPin)
        }
    }
    
    private func getUserLocation() -> CLLocationCoordinate2D {
        // Know user location
        return (locationManager.location?.coordinate)!
    }
    
}
