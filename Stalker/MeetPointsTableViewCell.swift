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
    func getMeetPoints() -> [[String: AnyObject]] {
        var result: [[String: AnyObject]] = []
        
        let user: [String: Any] = ["id": 0, "name": "alice"]
        let json = try? JSONSerialization.data(withJSONObject: user)
        
        // set up session
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: "")!)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "POST"
        request.httpBody = json
        
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
                guard let todo = try JSONSerialization.jsonObject(with: data) as? [String : AnyObject] else {
                    print("ERROR: trying to convert data to JSON")
                    return
                }
                result.append(todo)
            }
            catch {
                print("ERROR: trying to convert data to JSON")
            }
        })
        task.resume()
        
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
