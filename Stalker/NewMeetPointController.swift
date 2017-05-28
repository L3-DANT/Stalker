//
//  NewMeetPointController.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation
import UIKit

class NewMeetPointController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var addressOutlet: UITextField!
    @IBOutlet weak var cityOutlet: UITextField!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newMeetPoint(_ sender: UIButton) {
        if addressOutlet.text != nil && cityOutlet.text != nil {
            
            //MeetPoint(name: <#T##String#>, address: addressOutlet.text, latitude: <#T##Double#>, longitude: <#T##Double#>)
        }
    }

}
