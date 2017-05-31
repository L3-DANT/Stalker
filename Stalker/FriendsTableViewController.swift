//
//  FriendsTableViewController.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var friends = [User]()
    var friend = User()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadFriends()
    }
    
    private func loadFriends() {
        FriendshipService.getAll(isAccepted: true, completion: { (inner: UsersBuilder) in
            do {
                self.friends = try inner()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("Async error while fetching friends: \(error)")
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
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.friend = self.friends[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendsTableViewCell else {
            fatalError("The dequeue cell is not an instance of FriendsTableViewCell.")
        }
        
        // Fetches the appropriate friend for the data source layout
        self.friend = friends[indexPath.row]
        cell.friendLabel.text = self.friend.name
        
        return cell
    }
    
    // Delete Button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button
            
            func myHandler(alert: UIAlertAction) {
                let friendship = Friendship(emailSource: Session.getEmail()!, emailDest: self.friend.email, isAccepted: false)
                
                // Delete friendship
                FriendshipService.delete(friendship: friendship, completion: { (inner: FriendshipBuilder) in
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
            
            let otherAlert = UIAlertController(title: "Do you want to delete this friend?", message: "Your friend will be deleted.", preferredStyle: UIAlertControllerStyle.actionSheet)
            let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: myHandler)
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            // Relate actions to controllers
            otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            
            self.present(otherAlert, animated: true, completion: nil)
        })]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AFriendSegue" {
            let destinationViewController = segue.destination as! AFriendController
            destinationViewController.data = self.friend
        }
    }
    
}
