//
//  InscriptionController.swift
//  Stalker
//
//  Created by m2sar on 27/04/17.
//  Copyright © 2017 m2sar. All rights reserved.
//

import UIKit

class InscriptionController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func signUp(_ sender: UIButton) {
        if emailInput.text != "" && passwordInput.text != "" && nameInput.text != "" {
            
            let user = User(name: nameInput.text, email: emailInput.text!, password: passwordInput.text!)
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: user.toDictionary(), options: .prettyPrinted) {
                
                let url = URL(string: "http://35.187.15.102:8080/api/user/")!
                let request = NSMutableURLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                    if error != nil{
                        self.messageError(title: "Sign Up", message: "Error, fail service, please retry")
                        return
                    }
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        self.messageError(title: "Sign Up", message: "This user exists already")                        
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        if let parseJSON = json {
                            let userConnected = User(json: parseJSON as! [String : Any])
                            Defaults.standard.set(true, forKey: Defaults.userIsConnected)
                            Defaults.standard.set(userConnected.token, forKey: Defaults.userToken)
                            Defaults.standard.set(userConnected.email, forKey: Defaults.userEmail)
                            Defaults.standard.synchronize()
                            if userConnected.token != nil {
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "signUpToMap", sender: self)
                                }
                            }
                        }
                    } catch _ as NSError {
                        self.messageError(title: "Sign Up", message: "Error, fail service, please retry")
                    }
                }
                task.resume()
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setu p after loading the view, typically from a nib.
        nameInput.delegate = self
        nameInput.tag = 0
        emailInput.delegate = self
        emailInput.tag = 1
        passwordInput.delegate = self
        passwordInput.tag = 2
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
    
    func messageError(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

