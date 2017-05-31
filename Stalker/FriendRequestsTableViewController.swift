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
    
    var friends = [User]()
    var friend = User()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFriends()
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
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.friend = self.friends[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendRequestsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendRequestsTableViewCell else {
            fatalError("The dequeue cell is not an instance of FriendRequestsTableViewCell.")
        }
        
        // Fetches the appropriate friend for the data source layout
        self.friend = friends[indexPath.row]
        cell.friendLabel.text = self.friend.name
        
        return cell
    }
    
    // Add and decline Buttons
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .default, title: "Add", handler: { (action, indexPath) in
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button
            
            func myHandler(alert: UIAlertAction) {
                let friendship = Friendship(emailSource: self.friend.email, emailDest: Session.getEmail()!, isAccepted: true)
                
                // Update friendship
                FriendshipService.update(friendship: friendship, completion: { (inner: FriendshipBuilder) in
                    do {
                        _ = try inner()
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    catch let error {
                        print("Async error while updating friendship : \(error)")
                    }
                })
            }
            
            let otherAlert = UIAlertController(title: "Do you want to accept this friendship?", message: "This friend will be added.", preferredStyle: UIAlertControllerStyle.actionSheet)
            let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: myHandler)
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            // Relate actions to controllers
            otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            
            self.present(otherAlert, animated: true, completion: nil)
        }),
                UITableViewRowAction(style: .default, title: "Decline", handler: { (action, indexPath) in
                    
                    // The UIAlertControllerStyle ActionSheet is used when there are more than one button
                    
                    func myHandler(alert: UIAlertAction) {
                        let friendship = Friendship(emailSource: Session.getEmail(), emailDest: self.friend.email, isAccepted: false)
                        
                        // Delete friendship
                        FriendshipService.delete(friendship: friendship, completion: { ( inner: FriendshipBuilder) in
                            do {
                                _ = try inner()
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            catch let error {
                                print("Async error while deleting friendship: \(error)")
                            }
                        })
                    }
                    
                    let otherAlert = UIAlertController(title: "Do you want to decline this friendship?", message: "This request will be declined.", preferredStyle:UIAlertControllerStyle.actionSheet)
                    let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: myHandler)
                    let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    // Relate actions to controllers
                    otherAlert.addAction(callFunction)
                    otherAlert.addAction(dismiss)
                    
                    self.present(otherAlert, animated: true, completion: nil)
                })]
    }
    
    private func loadFriends() {
        FriendshipService.getAll(isAccepted: false, completion: { (inner: UsersBuilder) in
            do {
                self.friends = try inner()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("Async error while fetching MeetPoints: \(error)")
            }
        })
    }
    
}
