//
//  Message.swift
//  Alamofire iOS
//
//  Created by Shafto, Robin on 4/15/18.
//  Copyright © 2018 Alamofire. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import Alamofire

//let key = "735e6cff-5205-49b7-be80-7ec57c083aac"
//let client = "robin.shafto@mymail.champlain.edu"

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

class Message {
    public var id: String
    public var date: String
    public var client: String
//    public var ip: String?
    public var likes: Int
    public var dislikes: Int
    public var loc: CLLocationCoordinate2D?
    public var imageURL: String?
    public var image: UIImage?
    public var message: String
    
    
    init(json: [String: Any]) {
        client = (json["client"] as? String)!
        date = (json["date"] as? String)!
        id = (json["_id"] as? String)!
        if let coordinatesJSON = json["loc"] as? [Any] {
            if Double(String(describing: coordinatesJSON[0])) != nil {
                let longitude: Double = Double(String(describing: coordinatesJSON[0]))!
                let latitude: Double = Double(String(describing: coordinatesJSON[1]))!
                loc = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
            }
        }
        likes = json["likes"] as! Int
        dislikes = json["dislikes"] as! Int
        
        message = json["message"] as! String
        if message.contains(".jpg") {
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: message, options: [], range: NSRange(location: 0, length: message.utf16.count))
            for match in matches {
                guard let range = Range(match.range, in: message) else { continue }
                let url = message[range]
                if imageURL == nil && (url.hasSuffix("jpg") || url.hasSuffix("gif") || url.hasSuffix("png")) {
                    imageURL = String(url)
                    let address = URL(string: imageURL!)
                    image = UIImage(url: address!)
                }
            }
        }
    }
    
    func upvote() {
        var likes = (UserDefaults.standard.array(forKey: "likes") ?? []) as! [String]
        let dislikes = (UserDefaults.standard.array(forKey: "dislikes") ?? []) as! [String]
        if !likes.contains(id) && !dislikes.contains(id) {
            likes.append(id)
            self.likes += 1
            let url: String = "https://www.stepoutnyc.com/chitchat/like/" + id
            print("UPVOTED: ", message)
            Alamofire.request(url, method: .get , parameters: ["key" : UserDefaults.standard.string(forKey: "lastUsedKey")!, "client" : UserDefaults.standard.string(forKey: "lastUsedEmail")!])
            UserDefaults.standard.set(likes, forKey: "likes")
        }
    }
    
    func downvote() {
        let likes = (UserDefaults.standard.array(forKey: "likes") ?? []) as! [String]
        var dislikes = (UserDefaults.standard.array(forKey: "dislikes") ?? []) as! [String]
        if !likes.contains(id) && !dislikes.contains(id) {
            dislikes.append(id)
            self.dislikes += 1
            let url: String = "https://www.stepoutnyc.com/chitchat/dislike/" + id
            print("DOWNVOTED: ", message)
            Alamofire.request(url, method: .get , parameters: ["key" : UserDefaults.standard.string(forKey: "lastUsedKey")!, "client" : UserDefaults.standard.string(forKey: "lastUsedEmail")!])
            UserDefaults.standard.set(dislikes, forKey: "dislikes")
        }
    }
}




