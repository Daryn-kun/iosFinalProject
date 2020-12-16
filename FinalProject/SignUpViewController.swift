//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by nagato on 12/14/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var indiigoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.shadowRadius = 10.0
        signUpButton.layer.shadowOpacity = 0.3
        signUpButton.layer.shadowOffset = CGSize(width: 5, height: 8)
        signUpButton.clipsToBounds = false
        self.indiigoView.round(corners: [.topLeft, .topRight], cornerRadius: 20)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
    let userFullName = fullNameTextField.text
            let userEmail = emailTextField.text
            let userPassword = passwordTextField.text
            let userConfirmPassword = confirmPasswordTextField.text
            
            
            // Check for empty fields
            if(userFullName!.isEmpty || userEmail!.isEmpty || userPassword!.isEmpty || userConfirmPassword!.isEmpty){
                //Display alert message
                displayAlertMessage(userMessage: "All fiels are required")
                return
            }
            
            if(userPassword != userConfirmPassword){
                displayAlertMessage(userMessage: "Password do not match")
                return
            }
            // Store data
            UserDefaults.standard.set(userFullName, forKey: "userFullName")
            UserDefaults.standard.set(userEmail, forKey: "userEmail")
            UserDefaults.standard.set(userPassword, forKey: "userPassword")
            UserDefaults.standard.synchronize()
            let params = [
                "email" : userEmail ?? "No input detected",
                "password" : userPassword ?? "No input detected"
            ]
            Alamofire.request("https://reqres.in/api/register", method: .post, parameters: params).responseString {(response) in
                if response.result.isSuccess{
                    let myAlert = UIAlertController(title: "Alert", message: "Succesfully signed up!", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                        (action) in
                        myAlert.dismiss(animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    print("Your post \(response)")
                    let newUser = User()
                    newUser.fullName = userFullName
                    newUser.userEmail = userEmail
                    newUser.userPassword = userPassword
                    try! realm.write{
                        realm.add(newUser)
                    }
                } else {
                    self.displayAlertMessage(userMessage: "Something went wrong")
                    print("error")
                }
            }
            
            // Display alert with confirmation
            
            
        }
        
        @IBAction func accountHaveButtonTapped(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
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

