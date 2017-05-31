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
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try self.updateData()
        }
        catch let error {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateData() throws {
        guard let meetpoint = self.meetpoint else {
            throw DataError.invalid("meetpoint")
        }
        guard let zipCode = meetpoint.zipCode else {
            throw DataError.invalid("zipCode")
        }
        nameLabel.text = meetpoint.name
        addressLabel.text = meetpoint.address
        zipCodeLabel.text = "\(zipCode)"
        townLabel.text = meetpoint.town
    }
    
}
