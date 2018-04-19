//
//  ComposeMessageViewController.swift
//  ChitChat
//
//  Created by Shafto, Robin on 4/18/18.
//  Copyright © 2018 Shafto, Robin. All rights reserved.
//

import UIKit

class ComposeMessageViewController: UIViewController {
    var sendLocation: Bool = false
    @IBOutlet weak var MessageText: UITextView!
    @IBAction func IncludeLocationToggle(_ sender: UIButton) {
        if sendLocation {
            sender.alpha = 0.0
            sender.setImage(#imageLiteral(resourceName: "LocationOff"), for: .normal)
            sender.fadeIn(duration: 0.5)
        }
        else {
            sender.alpha = 0.0
            sender.setImage(#imageLiteral(resourceName: "LocationOn"), for: .normal)
            sender.fadeIn(duration: 0.5)
        }
        sendLocation = !sendLocation
    }
    @IBAction func Send(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// fade in animation
extension UIButton{
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
}
