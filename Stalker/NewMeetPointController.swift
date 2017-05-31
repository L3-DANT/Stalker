//
//  NewMeetPointController.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class NewMeetPointController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var town: UITextField!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createMeetPoint(_ sender: UIButton) {
        guard let name = name.text else {
            print("ERROR: Empty name")
            return
        }
        guard let address = address.text else {
            print("ERROR: Empty address")
            return
        }
        guard let zipCode = zipCode.text else {
            print("ERROR: Empty zipCode")
            return
        }
        guard let town = town.text else {
            print("ERROR: Empty town")
            return
        }
        let meetpoint = MeetPoint(name: name, address: address, zipCode: Int(zipCode), town: town)
        
        MeetPointService.create(meetpoint: meetpoint, completion: { (inner: MeetPointBuilder) in
            do {
                _ = try inner()
            }
            catch let error {
                print("Async error while creating meetpoint: \(error)")
            }
            
            DispatchQueue.main.async {
                self.view.reloadInputViews()
            }
        })
    }
    
}
