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
import MapKit

class FriendsTableViewController: UITableViewController {

    var friends = [User]()
    var friend = User()

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "friendCellSegue" {
            
            let viewController = segue.destination as! AFriendController
            viewController.friend = self.friend
            
        }
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
    
    public func getAllFriends() -> [User] {
        return self.friends
    }


    private func loadFriends(){
        
        let friend1 = User(name:"ally", lastPosition: Position(latitude: 48.846395, longitude: 2.356940))
        let friend2 = User(name: "bob", lastPosition: Position(latitude: 48.844793, longitude: 2.356940))
        let friend3 = User(name: "claude", lastPosition: Position(latitude: 48.844807, longitude: 2.354718))
        let friend4 = User(name: "eliott", lastPosition: Position(latitude: 48.845852, longitude: 2.354933))
        let friend5 = User(name: "fred", lastPosition: Position(latitude: 48.847666, longitude: 2.356778))
        
        
        friends += [friend1, friend2, friend3, friend4, friend5]
    }
}
