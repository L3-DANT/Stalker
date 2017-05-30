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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        emailInput.delegate = self
        emailInput.tag = 0
        passwordInput.delegate = self
        passwordInput.tag = 1
        if Defaults.standard.string(forKey: Defaults.userToken) != nil && Defaults.standard.bool(forKey: Defaults.userIsConnected) {
            let TabBarControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
            self.navigationController?.pushViewController(TabBarControllerObj!, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if emailInput.text != "" && passwordInput.text != "" {
            
            let user = User(email: emailInput.text!, password: passwordInput.text!)
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: user.toDictionary(), options: .prettyPrinted) {
                
                let url = URL(string: "\(Server.address)/\(Collection.user)/me")!
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
                            Defaults.standard.set(true, forKey: Defaults.userIsConnected)
                            Defaults.standard.set(userConnected.token, forKey: Defaults.userToken)
                            Defaults.standard.set(userConnected.email, forKey: Defaults.userEmail)
                            Defaults.standard.synchronize()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
    
    
}

