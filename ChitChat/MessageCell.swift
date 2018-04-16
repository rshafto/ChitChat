//
//  MessageCell.swift
//  Alamofire iOS
//
//  Created by Shafto, Robin on 4/15/18.
//  Copyright © 2018 Alamofire. All rights reserved.
//

import UIKit
import MapKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var mapDisplay: MKMapView!
    @IBOutlet weak var messageTextDisplay: UITextView!
    @IBOutlet weak var upvoteDisplay: UILabel!
    @IBOutlet weak var downvoteDisplay: UILabel!
    @IBOutlet weak var timestampDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
