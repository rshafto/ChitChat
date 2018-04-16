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
            imageDisplay.image = image
            imageDisplay.isHidden = false
        } else {
            imageDisplay.isHidden = true
        }
        
        print(message.loc)
//        if let location = message.loc {
//            print("~~~~~~~~~~~~location: ", location)
//            let latitude: CLLocationDegrees = location.latitude
//            let longitude: CLLocationDegrees = location.longitude
//            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
//            let regionRadius: CLLocationDistance = 400
//            let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius, regionRadius)
//            mapDisplay.setRegion(coordinateRegion, animated: true)
//            // display annotation pin
//            let annotation: MKAnnotation = PointerCoordinate(location: location)
//            mapDisplay.addAnnotation(annotation)
//            mapDisplay.isHidden = false
//        } else {
//            mapDisplay.isHidden = true
//        }
        
        timestampDisplay.text = message.date
        downvoteDisplay.text = "-" + String(message.dislikes)
        upvoteDisplay.text = "+" + String(message.likes)
    }
}
