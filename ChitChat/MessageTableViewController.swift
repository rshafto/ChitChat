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
    
    @IBAction func AddMessage(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Send new message", message: "Enter your message", preferredStyle: .alert)
        var newMessage: String = ""
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let imageButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let OKAction = UIAlertAction(title: "Enter", style: .default) { (action:UIAlertAction!) in
            newMessage = (alertController.textFields?[0].text)!
            print("Sending message:", newMessage)
            sendMessage(message: newMessage, sendLocation: imageButton.isSelected)
            self.getData()
        }
        
        alertController.addAction(CancelAction)
        imageButton.setBackgroundImage(#imageLiteral(resourceName: "LocationOn"), for: .selected)
        imageButton.setBackgroundImage(#imageLiteral(resourceName: "LocationOff"), for: .normal)
        imageButton.addTarget(self, action: #selector(MessageTableViewController.checkBoxAction(_:)), for: .touchUpInside)
        
        alertController.addAction(OKAction)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "message"
        }
        
        alertController.view.addSubview(imageButton)
//        let verticalConstraint = NSLayoutConstraint(item: imageButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
//        alertController.view.addConstraints([verticalConstraint])
        self.present(alertController, animated: false, completion: nil)
    }
    
    @IBAction func RefreshMessages(_ sender: UIBarButtonItem) {
        getData()
    }
    
    @IBAction func LoadMoreMessages(_ sender: UIButton) {
        // get more data
    }
    
    func getData() {
        Alamofire.request("https://www.stepoutnyc.com/chitchat", method: .get, parameters: ["key" : key, "client" : client]).responseJSON { response in
            if let json = response.result.value {
                let jsonDict = json as! NSDictionary
                let jsonMessages = jsonDict["messages"] as! NSArray
                self.messages.removeAll()
                
                for jsonMessage in jsonMessages {
                    let messageText = jsonMessage as! NSDictionary as! [String: Any]
                    self.message = Message(json: messageText)
                    self.messages.append(self.message)
                    print (self.message.id)
                }
            }
            self.tableView.reloadData()
            print("reloaded data...")
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let upvote = UIContextualAction(style: .destructive, title: "Like") { (action, view, handler) in
            self.messages[indexPath.row].upvote()
            self.tableView.reloadRows(at: [indexPath], with: .left)
        }
        upvote.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [upvote])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let downvote = UIContextualAction(style: .destructive, title: "Dislike") { (action, view, handler) in
            self.messages[indexPath.row].downvote()
            self.tableView.reloadRows(at: [indexPath], with: .right)
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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 1
        }
        return self.messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadMoreCell", for: indexPath) as! LoadMoreCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.setMessage(message: messages[indexPath.row])

        return cell
    }


}
