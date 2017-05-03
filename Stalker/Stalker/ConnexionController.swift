//
//  ConnexionController.swift
//  Stalker
//
//  Created by m2sar on 27/04/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class ConnexionController: UIViewController {
    
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    
    let session = Session()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setu p after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

