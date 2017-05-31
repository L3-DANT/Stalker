//
//  AFriendController.swift
//  Stalker
//
//  Created by m2sar on 30/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import Foundation
import UIKit

class AFriendController: UIViewController {
    
    var data: User?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    //latitude
    //longitude
    
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
        guard let friend = self.data else {
            throw DataError.invalid("friend")
        }
        guard let position = friend.lastPosition else {
            throw DataError.invalid("position")
        }
        guard let latitude = position.latitude else {
            throw DataError.invalid("latitude")
        }
        guard let longitude = position.longitude else {
            throw DataError.invalid("longitude")
        }
        nameLabel.text = friend.name
        positionLabel.text = "\(latitude) \(longitude)"
    }
    
}
