//
//  ConnexionController.swift
//  Stalker
//
//  Created by m2sar on 27/04/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class ConnexionController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    let userToken = "token"
    let userEmail = "email"
    let userIsConnected = "isConnected"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        emailInput.tag = 0
        passwordInput.delegate = self
        passwordInput.tag = 1
        if defaults.string(forKey: self.userToken) != nil && defaults.bool(forKey: self.userIsConnected) {
            let TabBarControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
            self.navigationController?.pushViewController(TabBarControllerObj!, animated: false)
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if emailInput.text != "" && passwordInput.text != "" {
            
            let user = User(email: emailInput.text!, password: passwordInput.text!)
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: user.toDictionary(), options: .prettyPrinted) {
                
                let url = URL(string: "http://35.187.15.102:8080/api/user/authenticate")!
                let request = NSMutableURLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                    if error != nil{
                        self.messageError(title: "Sign In", message: "Error, fail service, please retry")
                        return
                    }
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        self.messageError(title: "Sign In", message: "Wrong password or email")
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        if let parseJSON = json {
                            let userConnected = User(json: parseJSON as! [String : Any])
                            self.defaults.set(true, forKey: self.userIsConnected)
                            self.defaults.set(userConnected.token, forKey: self.userToken)
                            self.defaults.set(userConnected.email, forKey: self.userEmail)
                            self.defaults.synchronize()
                            if userConnected.token != nil {
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "signInToMap", sender: self)
                                }
                            }
                        }
                    } catch _ as NSError {
                        self.messageError(title: "Sign In", message: "Error, fail service, please retry")
                    }
                }
                task.resume()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func messageError(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

