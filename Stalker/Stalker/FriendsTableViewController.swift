//
//  FriendsTableViewController.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//
//https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/CreateATableView.html
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriends()
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendsTableViewCell else {
                fatalError("The dequeue cell is not an instance of FriendTableViewCell")
            }
        
        //Fetches the appropriate friend for the data source layout
        let friend = friends[indexPath.row]
        cell.friendLabel.text = friend.name

        return cell
    }
    
    //Delete Button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button.
            
            func myHandler(alert: UIAlertAction){
                self.friends.remove(at: indexPath.row)
                tableView.reloadData()
                print("You tapped: \(alert.title)")
            }
            
            let otherAlert = UIAlertController(title: "Do you want to delete this friend?", message: "your friend will be deleted", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            
            
            let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: myHandler)
            
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            // relate actions to controllers
            otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            
            self.present(otherAlert, animated: true, completion: nil)
            
            
        })]
    }


    private func loadFriends(){
        let friend1 = Friend(name:"ally", position:"Amiens")
        let friend2 = Friend(name: "bob", position: "Bourges")
        let friend3 = Friend(name: "claude", position: "Caen")
        let friend4 = Friend(name: "eliott", position: "Epinay")
        let friend5 = Friend(name: "fred", position: "Fontainebleau")
        
        friends += [friend1, friend2, friend3, friend4, friend5]
    }
}
