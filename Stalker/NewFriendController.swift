//
//  NewFriendController.swift
//  Stalker
//
//  Created by kvin on 30/05/2017.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class NewFriendController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var email: UITextField!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createFriendship(_ sender: UIButton) {
        guard let email = email.text else {
            print("ERROR: Empty email")
            return
        }
        let friendship = Friendship(emailSource: Session.getEmail(), emailDest: email, isAccepted: true)
        
        FriendshipService.create(friendship: friendship, completion: { (inner: FriendshipBuilder) in
            do {
                _ = try inner()
            }
            catch let error {
                print("Async error while creating friendship: \(error)")
            }
            
            DispatchQueue.main.async {
                self.view.reloadInputViews()
            }
        })
    }
    
}
