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
    var meetpoint = MeetPoint()
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMeetPoints()
    }
    
    private func loadMeetPoints() {
        MeetPointService.getAll(completion: { (inner: MeetPointsBuilder) in
            do {
                self.meetpoints = try inner()
                
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
        return self.meetpoints.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.meetpoint = self.meetpoints[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MeetPointsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MeetPointsTableViewCell else {
            fatalError("The dequeue cell is not an instance of MeetPointTableViewCell.")
        }
        
        // Fetches the appropriate friend for the data source layout
        self.meetpoint = self.meetpoints[indexPath.row]
        cell.meetpointLabel.text = self.meetpoint.name
        
        return cell
    }
    
    // Delete Button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button
            
            func myHandler(alert: UIAlertAction){
                // Delete meetpoint
                MeetPointService.delete(meetpoint: self.meetpoint, completion: { (inner: MeetPointBuilder) in
                    do {
                        _ = try inner()
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    catch let error {
                        print("Async error while deleting meetpoint: \(error)")
                    }
                })
            }
            
            let otherAlert = UIAlertController(title: "Do you want to delete this meetpoint?", message: "Your meetpoint will be deleted.", preferredStyle: UIAlertControllerStyle.actionSheet)
            let callFunction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: myHandler)
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            // Relate actions to controllers
            otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            
            self.present(otherAlert, animated: true, completion: nil)
        })]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AMeetPointSegue" {
            let destinationViewController = segue.destination as! AMeetPointController
            destinationViewController.data = self.meetpoint
            
        }
    }
    
}
