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
    
    @IBAction func loginButton(_ sender: UIButton) {
        if (emailInput.text != nil && passwordInput.text != nil) {
            
            let formParams : [String: String] = ["mail": emailInput.text!,"password": passwordInput.text!]
            
            // create post request
            let url = URL(string: "http://35.187.15.102:8080/api/user/authenticate")!
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // insert json data to the request
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: formParams)
            }
            catch {
                print(error)
            }
            
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                
                // Check for error
                if (error != nil) {
                    print("error: \(error)")
                    return
                }
                
                // Print out response string
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString: \(responseString)")
                
                
//                guard let data = data, error == nil else {
//                    print(error?.localizedDescription ?? "No data")
//                    return
//                }
                
//                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
//                    self.token = responseJSON?.value(forKeyPath: "token") as? String
//                    print(self.token)
//                }
                
            }
            
            task.resume()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setu p after loading the view, typically from a nib.
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

