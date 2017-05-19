//
//  MeetPointsTableViewController.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class MeetPointsTableViewController: UITableViewController {

    // MARK: Properties
    var meetpoints = [MeetPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMeetPoints()
        self.tableView.reloadData()
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
        return meetpoints.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MeetPointsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MeetPointsTableViewCell else {
            fatalError("The dequeue cell is not an instance of MeetPointTableViewCell")
        }
        
        //Fetches the appropriate friend for the data source layout
        let meetpoint = meetpoints[indexPath.row]
        cell.meetpointLabel.text = meetpoint.name
        
        return cell
    }
    
    //Delete Button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button.
            
            func myHandler(alert: UIAlertAction){
                self.meetpoints.remove(at: indexPath.row)
                tableView.reloadData()
                print("You tapped: \(alert.title)")
            }
            
            let otherAlert = UIAlertController(title: "Do you want to delete this meetpoint?", message: "your meetpoint will be deleted", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            
            
            let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: myHandler)
            
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            // relate actions to controllers
            otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            
            self.present(otherAlert, animated: true, completion: nil)
            
            
        })]
    }
    
    
    private func loadMeetPoints(){
        let meetpoint1 = MeetPoint(name: "Tour Eiffel", address: "ave de la Tour Eiffel", latitude: 45.02, longitude: 46.25)
        let meetpoint2 = MeetPoint(name: "Arc de Triomphe", address: "ave de l'Arc de Triomphe", latitude: 45.02, longitude: 46.25)
        let meetpoint3 = MeetPoint(name: "Notre Dame", address: "ave de Notre Dame", latitude: 45.02, longitude: 46.25)
        
        meetpoints += [meetpoint1, meetpoint2, meetpoint3]
    }
 

}
