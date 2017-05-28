//
//  MeController.swift
//  Stalker
//
//  Created by Agnès Herrera on 28/05/2017.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class MeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareMyPosition(_ sender: UISwitch) {
        Defaults.standard.set(sender.isOn, forKey: Defaults.userSharingPosition)
        Defaults.standard.synchronize()
    }
    
    @IBAction func buyPremium(_ sender: UIButton) {
        self.messageError(title: "Premium", message: "Available soon")
    }
    
    @IBAction func myItineraris(_ sender: UIButton) {
        self.messageError(title: "My Itineraries", message: "Available soon")
    }
    @IBAction func logOut(_ sender: UIButton) {
        Defaults.standard.set(false, forKey: Defaults.userIsConnected)
        Defaults.standard.set(nil, forKey: Defaults.userToken)
        Defaults.standard.synchronize()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "logOutToSignIn", sender: self)
        }
    }
    
    func messageError(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
