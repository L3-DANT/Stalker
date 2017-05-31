//
//  MeController.swift
//  Stalker
//
//  Created by Agnès Herrera on 28/05/2017.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class MeController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    private func loadData() {
        nameLabel.text = Session.getName()
        emailLabel.text = Session.getEmail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareMyPosition(_ sender: UISwitch) {
        Session.setIsSharingPosition(sender.isOn)
        Session.standard.synchronize()
    }
    
    @IBAction func buyPremium(_ sender: UIButton) {
        self.messageError(title: "Premium", message: "Available soon")
    }
    
    @IBAction func myItineraris(_ sender: UIButton) {
        self.messageError(title: "My Itineraries", message: "Available soon")
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        Session.setIsConnected(false)
        Session.standard.setNilValueForKey("token")
        Session.standard.synchronize()
        exit(0)
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
