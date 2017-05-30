//
//  FriendRequestsTableViewController.swift
//  Stalker
//
//  Created by m2sar on 30/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class FriendRequestsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var maybeFriends = [User]()
    var maybeFriend = User()
    var maybeFriendship = Friendship()
    
    let cellReuseIdentifier = "cell"
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.getFriends(isAccepted: false, completion: { (inner: () throws -> [User]) in
            do {
                self.maybeFriends = try inner()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("Async error while fetching MeetPoints: \(error)")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maybeFriends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.maybeFriend = self.maybeFriends[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.maybeFriends[indexPath.row].name
        
        return cell
    }
    
    //Accept Button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .default, title: "Add", handler: { (action, indexPath) in
            
            self.maybeFriendship = Friendship(emailSource: self.maybeFriend.email, emailDest: Profile.getEmail()!, isAccepted: true)
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button.
            
            func myHandler(alert: UIAlertAction){
                
                //Update isAccepted : true
                FriendshipService.update(friendship: self.maybeFriendship, completion: { (inner: EmptyBuilder) in
                    do {
                        try inner()
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    catch let error {
                        print("Async error while fetching MeetPoints: \(error)")
                    }
                })
                
                //self.friends
                tableView.reloadData()
            }
            
            let otherAlert = UIAlertController(title: "Do you want to accept this friendship?", message: "this demand will be accepted", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            
            
            let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: myHandler)
            
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            // relate actions to controllers
            otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            
            self.present(otherAlert, animated: true, completion: nil)
            
        }),
                UITableViewRowAction(style: .default, title: "Refuse", handler: { (action, indexPath) in
                    
                    // The UIAlertControllerStyle ActionSheet is used when there are more than one button.
                    
                    self.maybeFriendship = Friendship(emailSource: self.maybeFriend.email, emailDest: Profile.getEmail(), isAccepted: false)
                    
                    func myHandler(alert: UIAlertAction){
                        
                        /*FriendshipService.update(friendship: self.maybeFriendship, completion: { (inner: EmptyBuilder) in
                         do {
                         try inner()
                         
                         DispatchQueue.main.async {
                         self.tableView.reloadData()
                         }
                         }
                         catch let error {
                         print("Async error while fetching MeetPoints: \(error)")
                         }
                         })*/
                        
                        //self.friends
                        //tableView.reloadData()
                        
                    }
                    let otherAlert = UIAlertController(title: "Do you want to refuse this friend?", message: "this demand will be deleted", preferredStyle:UIAlertControllerStyle.actionSheet)
                    
                    
                    
                    let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: myHandler)
                    
                    let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    // relate actions to controllers
                    otherAlert.addAction(callFunction)
                    otherAlert.addAction(dismiss)
                    
                    self.present(otherAlert, animated: true, completion: nil)
                    
                })
        ]
        
    }
    
    
    
}
