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
        let userEmail:String! = emailInput.text
        let userPassword:String! = passwordInput.text
        
        if((userEmail!.isEmpty) || (userPassword!.isEmpty)){
            print("\n\n\nUser email or password are empty !\n\n\n")
            return
        }
        
        //Envoi les données de log in
        
        let postEndpoint: String = "http://35.187.15.102:8080/api/user/authenticate"
        
        let url = URL(string: postEndpoint)!
        
        let session = URLSession.shared
        
        let postParams : [String: String] = ["mail": userEmail,"password":userPassword]
        
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: postParams, options: JSONSerialization.WritingOptions())
            
            
            
        } catch {
            
            print("\n\n\nERROR: LoginViewController\n\n\n")
            
        }
        
        
        session.dataTask(with: request, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let realResponse = response as? HTTPURLResponse, realResponse.statusCode == 200 else {
                    
                    print("\n\n\nERROR 2 : LoginView COntroller\n\n\n")
                    
                    return
                    
            }
            
            if let postString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) as? String {
                
                print("le POST: " + postString)
                
                if(postString != "[]"){
                    //Then LogIn is successfully done
//                    UserDefaults.standardUserDefaults.set(true, forKey: "isUserLogIn")
//                    UserDefaults.standardUserDefaults().setValue(userEmail, forKey: "myName")
//                    UserDefaults.standardUserDefaults().synchronize()
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                    
//                    var friends = postString.characters.split{$0 == ","}.map(String.init)
//                    let ami: Amis = Amis.getInstance
//                    var user :User
//                    ami.deleteAll([], str: "All")
//                    for i in 0...friends.count-1 {
//                        friends[i] = friends[i].stringByReplacingOccurrencesOfString("\"", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                        friends[i] = friends[i].stringByReplacingOccurrencesOfString("[", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                        friends[i] = friends[i].stringByReplacingOccurrencesOfString("]", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                        if (i != 0){
//                            user = User(name: friends[i], category: "Friends", coorX: 0, coorY: 0)
//                            ami.add(user, str: "Friends")
//                        }else{
//                            NSUserDefaults.standardUserDefaults().setValue(friends[0], forKey: "myName")
//                        }
//                    }
                }else{
                    print("\n\n\nWrong Login or Password\n\n\n")
                    return
                }
//                self.performSelectorOnMainThread(#selector(ConnexionController.updatePostLabel(_:)), withObject: postString, waitUntilDone: false)
            }
            
        }).resume()
        
        
        
    }
//        if (emailInput.text != nil && passwordInput.text != nil) {
//            
//            let formParams : [String: String] = ["mail": emailInput.text!,"password": passwordInput.text!]
//            
//            // create post request
//            let url = URL(string: "http://35.187.15.102:8080/api/user/authenticate")!
//            
//            var request = URLRequest(url: url)
//            
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            // insert json data to the request
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: formParams)
//            }
//            catch {
//                print(error)
//            }
//            
//            let task = URLSession.shared.dataTask(with: request) {
//                data, response, error in
//                
//                // Check for error
//                if (error != nil) {
//                    print("error: \(error)")
//                    return
//                }
//                
//                // Print out response string
//                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                print("responseString: \(responseString)")
        
 //------------>Beside commented by kevin
//                guard let data = data, error == nil else {
//                    print(error?.localizedDescription ?? "No data")
//                    return
//                }
                
//                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
//                    self.token = responseJSON?.value(forKeyPath: "token") as? String
//                    print(self.token)
//                }
//-----------------
//            }
//            
//            task.resume()
//            
//        }
//    }
    
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

