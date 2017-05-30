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
    
    var friend: User?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = self.friend?.name
        positionLabel.text = "\(self.friend?.lastPosition)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
