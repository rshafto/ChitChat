//
//  MessageCell.swift
//  Alamofire iOS
//
//  Created by Shafto, Robin on 4/15/18.
//  Copyright © 2018 Alamofire. All rights reserved.
//

import UIKit
import MapKit

class PointerCoordinate: NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    
    init(location: CLLocationCoordinate2D) {
        self.coordinate = location
    }
}

class MessageCell: UITableViewCell {
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var mapDisplay: MKMapView!
    @IBOutlet weak var messageTextDisplay: UITextView!
    @IBOutlet weak var upvoteDisplay: UILabel!
    @IBOutlet weak var downvoteDisplay: UILabel!
    @IBOutlet weak var timestampDisplay: UILabel!
    
    var message: Message?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapDisplay.isHidden = true
        imageDisplay.isHidden = true
    }
    
    func setMessage(message: Message) {
        self.message = message
        messageTextDisplay.text = message.message
        if let image = message.image {
//            message.testMessage()
            imageDisplay.image = image
            imageDisplay.isHidden = false
        } else {
            imageDisplay.isHidden = true
        }
        
        if let location = message.loc {
            let regionRadius: CLLocationDistance = 0.01
            if CLLocationCoordinate2DIsValid(location) {
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
                mapDisplay.isHidden = false
                mapDisplay.setRegion(coordinateRegion, animated: true)
                mapDisplay.isZoomEnabled = true
                let annotation: MKAnnotation = PointerCoordinate(location: location)
                mapDisplay.addAnnotation(annotation)
            } else {
                mapDisplay.isHidden = true
            }
        } else {
            mapDisplay.isHidden = true
        }
        
        timestampDisplay.text = message.date
        downvoteDisplay.text = "👎" + String(message.dislikes)
        upvoteDisplay.text = "👍" + String(message.likes)
    }
    
    func upvote() {
        message?.upvote()
        upvoteDisplay.text = "👍" + String((message?.likes)! + 1)
    }
    
    func downvote() {
        message?.downvote()
        downvoteDisplay.text = "👎" + String((message?.dislikes)! + 1)
    }
}
