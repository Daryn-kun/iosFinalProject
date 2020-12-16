//
//  LoginViewController.swift
//  FinalProject
//
//  Created by nagato on 12/14/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var purpleView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.masksToBounds = true
        loginButton.layer.shadowRadius = 10.0
        loginButton.layer.shadowOpacity = 0.3
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 8)
        loginButton.clipsToBounds = false
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.shadowRadius = 10.0
        emailTextField.layer.shadowOpacity = 0.3
        emailTextField.layer.shadowOffset = CGSize(width: 5, height: 8)
        emailTextField.clipsToBounds = false
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.shadowRadius = 10.0
        passwordTextField.layer.shadowOpacity = 0.3
        passwordTextField.layer.shadowOffset = CGSize(width: 5, height: 8)
        passwordTextField.clipsToBounds = false
        self.purpleView.round(corners: [.bottomLeft, .bottomRight], cornerRadius: 20)
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    let userEmail = emailTextField.text
            let userPassword = passwordTextField.text
            
            let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
            let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
            if(userEmailStored == userEmail){
                if(userPasswordStored == userPassword){
                    let params = [
                        "email" : userEmail ?? "No input detected",
                        "password" : userPassword ?? "No input detected"
                    ]
                    Alamofire.request("https://reqres.in/api/login", method: .post, parameters: params).responseString {(response) in
                        if response.result.isSuccess{
                            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                            UserDefaults.standard.synchronize()
                            self.dismiss(animated: true, completion: nil)
                            print("Your post \(response)")
                        } else {
                            self.displayAlertMessage(userMessage: "Something went wrong")
                            print("error")
                        }
                    }
                } else{
                    self.displayAlertMessage(userMessage: "Incorrect password")
                }
            } else{
                self.displayAlertMessage(userMessage: "Incorrect email")
            }
            
        }
        func displayAlertMessage(userMessage: String){
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                (action) in
                myAlert.dismiss(animated: true, completion: nil)
            }))
            self.present(myAlert, animated: true, completion: nil)
        }
    
   
}
extension UIView {
    
    func round(corners: UIRectCorner, cornerRadius: Double) {
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
}
