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
    
    
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
