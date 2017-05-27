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
    
    var token:String?
    let userToken = "token"
    let userEmail = "email"
    let userIsConnected = "isConnected"
    let defaults = UserDefaults.standard
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let user = User(email: emailInput.text!, password: passwordInput.text!)
        
        if user.email != nil && user.password != nil {
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: user.toDictionary(), options: .prettyPrinted) {
                
                let url = NSURL(string: "http://35.187.15.102:8080/api/user/authenticate")!
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                    if error != nil{
                        print(error?.localizedDescription)
                        return
                    }
                    
                    if response?.value(forKey: "status code") != 200 {
                        self.messageError(title: "Sign In", message: "http error")
                        return
                    }
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        if let parseJSON = json {
                            let resultToken: String? = parseJSON["token"] as? String
                            let resultEmail: String? = parseJSON["email"] as? String
                            print("token: \(resultToken)")
                            print("requete complete: \n \(parseJSON)")
                            self.defaults.set(true, forKey: self.userIsConnected)
                            self.defaults.set(resultToken, forKey: self.userToken)
                            self.defaults.set(resultEmail, forKey: self.userEmail)
                            self.defaults.synchronize()
                            if resultToken != nil {
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "mapSegue", sender: self)
                                }
                            }
                        }
                    } catch _ as NSError {
                        self.messageError(title: "Sign In", message: "error")
                    }
                }
                task.resume()
            }
        }
    }
    
    //let user = User(email: emailInput.text!, password: passwordInput.text!)
    //        let dictionary: [String: Any] = ["email": "alice@bob.com", "password": 1234]
    //
    //        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
    //            let url = URL(string: "http://35.187.15.102:8080/api/user/authenticate")!
    //            var request = URLRequest(url: url)
    //            request.httpMethod = "POST"
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.httpBody = jsonData
    //
    //            let session = URLSession.shared
    //            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
    //                guard error == nil else {
    //                    self.messageError(title: "Sign In", message: "Network Error, please retry")
    //                    return
    //                }
    //                guard let data = data else {
    //                    self.messageError(title: "Sign Up", message: "Service Error, please retry")
    //                    return
    //                }
    //                guard response == nil  else {
    //                    print("response")
    //                    let status = response?.value(forKey: "status code")
    //                    print("status: \(status)")
    //                    return
    //                }
    //
    //                do {
    //                    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    //
    //                    if let parseJSON = json {
    //                        let userConnected = User(json: parseJSON!)
    //                        self.defaults.set(true, forKey: self.userIsConnected)
    //                        self.defaults.set(userConnected.token, forKey: self.userToken)
    //                        self.defaults.set(userConnected.email, forKey: self.userEmail)
    //                        self.defaults.synchronize()
    //
    //                        if userConnected.token != nil {
    //                            DispatchQueue.main.async {
    //                                self.performSegue(withIdentifier: "mapSegue", sender: self)
    //                            }
    //                        }
    //
    //
    //                    }
    //                }
    ////                catch let error as NSException {
    ////                    print(error)
    ////                    self.messageError(title: "Sign In", message: "Error sign in")
    ////                }
    //
    //            })
    //            task.resume()
    //        }
    //        else {
    //            self.messageError(title: "Sign In", message: "Application Error, please rety")
    //        }
    
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        emailInput.tag = 0
        passwordInput.delegate = self
        passwordInput.tag = 1
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
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

