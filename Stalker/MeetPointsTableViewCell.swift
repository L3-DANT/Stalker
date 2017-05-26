//
//  MeetPointsTableViewCell.swift
//  Stalker
//
//  Created by m2sar on 10/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class MeetPointsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var meetpointLabel: UILabel!
    
    // MARK: Methods
    func getMeetPoints() throws -> [MeetPoint] {
        var result = [MeetPoint]()
        
        let user = User(name: "alice", lastPosition: "0.0")
        let json = try? JSONSerialization.data(withJSONObject: user)
        
        // set up session
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "http://35.187.15.102:8080/")!)
        //        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        DispatchQueue.main.async {
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                guard error == nil else {
                    print("ERROR: POST on /todos/1")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("ERROR: did not receive data")
                    return
                }
                do {
                    guard let meetpoints = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] else {
                        print("ERROR: trying to convert data to JSON")
                        return
                    }
                    for meetpoint in meetpoints {
                        let meetpoint = MeetPoint(json : meetpoint)
                        result.append(meetpoint)
                    }
                }
                catch {
                    print("ERROR: trying to convert data to JSON")
                }
            })
            task.resume()
        }
        
        return result
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
