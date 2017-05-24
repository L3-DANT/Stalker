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
    
    @IBAction func signIn(_ sender: UIButton) {
        //TODO: gerer exception email et password nil
        if let dict: [String: String?] = ["email": emailInput.text, "password": passwordInput.text] {
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                
                
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
                                    self.performSegue(withIdentifier: "signInToMap", sender: self)
                                }
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }        
                }          
                task.resume()
            }
        }
    }
    
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
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }


}

