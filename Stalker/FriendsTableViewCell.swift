//
//  FriendsTableViewCell.swift
//  Stalker
//
//  Created by m2sar on 04/05/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var friendLabel: UILabel!
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
