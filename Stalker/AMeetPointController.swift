//
//  AMeetPointController.swift
//  Stalker
//
//  Created by m2sar on 29/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation
import UIKit

class AMeetPointController: UIViewController {
    
    var meetpoint: MeetPoint?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pcLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.meetpoint != nil){
            nameLabel.text = self.meetpoint?.name
            addressLabel.text = self.meetpoint?.address
            pcLabel.text = "\(String(describing: self.meetpoint?.zipCode))"
            cityLabel.text = self.meetpoint?.town
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
