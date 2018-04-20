//
//  MessageInteractions.swift
//  ChitChat
//
//  Created by Shafto, Robin on 4/18/18.
//  Copyright © 2018 Shafto, Robin. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

func sendMessage(message: String, sendLocation: Bool) {
    var lat: String = "1.2"
    var lon: String = "3.4"
    
    if sendLocation {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse){
            currentLocation = locManager.location
            
            lon = "1.2" //"\(currentLocation.coordinate.longitude)"
            lat = "2.3" //"\(currentLocation.coordinate.latitude)"
        }
        //if (CLLocationManager.locationServicesEnabled()) {
            currentLocation = locManager.location
            locManager.desiredAccuracy = 1.0    // Who really knows what values these need?
            locManager.distanceFilter = 1.0
            locManager.startUpdatingLocation()
            if locManager.location != nil {
                lon = "\(currentLocation.coordinate.longitude)"
                lat = "\(currentLocation.coordinate.latitude)"
            }
            locManager.stopUpdatingLocation()
        //}*/
    }
    //let formattedMessage = message.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    
    //var url: String = "https://www.stepoutnyc.com/chitchat?key=735e6cff-5205-49b7-be80-7ec57c083aac&client=robin.shafto@mymail.champlain.edu&message="+formattedMessage!
    //url += "&lat="+lat+"&lon="+lon
    let url: String = "https://www.stepoutnyc.com/chitchat"
    
    Alamofire.request(url, method: .post , parameters: ["key" : key, "client" : client, "message" : message, "lat" : lat, "lon" : lon])
}


