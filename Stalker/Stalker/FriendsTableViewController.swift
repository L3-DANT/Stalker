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


    private func loadFriends(){
        let friend1 = Friend(name:"ally", position:"Amiens")
        let friend2 = Friend(name: "bob", position: "Bourges")
        let friend3 = Friend(name: "claudine", position: "Caen")
        let friend4 = Friend(name: "eliott", position: "Epinay")
        
        friends += [friend1, friend2, friend3, friend4]
    }
}
