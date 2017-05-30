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
        
        MeetPointService.getAll(completion: { (inner: () throws -> [MeetPoint]) in
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
        return meetpoints.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MeetPointsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MeetPointsTableViewCell else {
            fatalError("The dequeue cell is not an instance of MeetPointTableViewCell")
        }
        
        // TODO: set meetpoint
        
        //Fetches the appropriate friend for the data source layout
        self.meetpoint = meetpoints[indexPath.row]
        
        cell.meetpointLabel.text = meetpoint.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "meetPointCellSegue" {
            
            let viewController = segue.destination as! AMeetPointController
            viewController.meetpoint = self.meetpoint
            
        }
    }
    
    //Delete Button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            
            // The UIAlertControllerStyle ActionSheet is used when there are more than one button.
            
            func myHandler(alert: UIAlertAction){
                self.meetpoints.remove(at: indexPath.row)
                tableView.reloadData()
                //                print("You tapped: \(alert.title)")
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
    
    
}
