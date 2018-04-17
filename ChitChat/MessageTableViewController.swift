//
//  MessageTableViewController.swift
//  Alamofire iOS
//
//  Created by Shafto, Robin on 4/15/18.
//  Copyright © 2018 Alamofire. All rights reserved.
// key:735e6cff-5205-49b7-be80-7ec57c083aac

import UIKit
import Alamofire

class MessageTableViewController: UITableViewController {
    var messages: [Message] = []
    var message: Message!
    
    func getData() {
        Alamofire.request("https://www.stepoutnyc.com/chitchat", method: .get, parameters: ["key" : key, "client" : client]).responseJSON { response in
            if let json = response.result.value {
                let jsonDict = json as! NSDictionary
                let jsonMessages = jsonDict["messages"] as! NSArray
                
                for jsonMessage in jsonMessages {
                    let messageText = jsonMessage as! NSDictionary as! [String: Any]
                    self.message = Message(json: messageText)
                    self.messages.append(self.message)
                }
            }
            self.tableView.reloadData()
            print("reloaded data...")
        }
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
//            print("more button tapped")
//        }
//        more.backgroundColor = UIColor.lightGray
//
//        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
//            print("share button tapped")
//        }
//        share.backgroundColor = UIColor.blue
//
//        return [share, more]
//    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let upvote = UIContextualAction(style: .destructive, title: "Like") { (action, view, handler) in
            self.messages[indexPath.row].upvote()
        }
        upvote.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [upvote])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let downvote = UIContextualAction(style: .destructive, title: "Dislike") { (action, view, handler) in
            self.messages[indexPath.row].downvote()
        }
        downvote.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [downvote])
        return configuration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        tableView.rowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.setMessage(message: messages[indexPath.row])

        return cell
    }


}
