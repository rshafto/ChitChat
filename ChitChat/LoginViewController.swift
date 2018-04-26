//
//  LoginViewController.swift
//  ChitChat
//
//  Created by Hoffman, Evan on 4/24/18.
//  Copyright © 2018 Shafto, Robin. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var keyField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var validated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.text = UserDefaults.standard.string(forKey: "lastUsedEmail")
        keyField.text = UserDefaults.standard.string(forKey: "lastUsedKey")
        emailField.delegate = self
        keyField.delegate = self
        loginButton.isEnabled = emailField.text != "" && keyField.text != ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            if let client = emailField.text, let key = keyField.text {
                Alamofire.request("https://www.stepoutnyc.com/chitchat", method: .get, parameters: ["key" : key, "client": client, "limit": 1]).responseJSON { response in
                    if let json = response.result.value as? NSDictionary {
                        self.validated = ((json["code"] as? String) == nil)
                    }
                }
                if validated {
                    UserDefaults.standard.set(emailField.text, forKey: "lastUsedEmail")
                    UserDefaults.standard.set(keyField.text, forKey: "lastUsedKey")
                } else {
                    let shake = CABasicAnimation(keyPath: "position")
                    shake.duration = 0.1
                    shake.repeatCount = 3
                    shake.autoreverses = true
                    shake.fromValue = NSValue(cgPoint: CGPoint(x: loginButton.center.x, y: loginButton.center.y))
                    shake.toValue = NSValue(cgPoint: CGPoint(x: loginButton.center.x - 10, y: loginButton.center.y))
                    loginButton.layer.add(shake, forKey: "position")
                }
                return validated
            }
        }
        return false
    }
// e0ba6f5d-9f79-4bf3-a7f8-298228850975
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        if emailField.text != "", keyField.text != "" {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // To authenticate, send a test request
        
    }
    
}
