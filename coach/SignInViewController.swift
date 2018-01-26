//
//  SignInViewController.swift
//  coach
//
//  Created by Andre Faruolo on 01/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var signInButtonOutlet: UIButton!
    
    var isUsernameFieldValid : Bool = false
    var isPasswordFieldValid : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var textFields = [usernameTextFieldOutlet, passwordTextFieldOutlet]
        self.setupTextFields(textFields: textFields as! [UITextField])

        
    }

    func setupTextFields(textFields: [UITextField]){
        for textField in textFields {
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 2
            textField.frame.size.height = 45
            textField.delegate = self
        }
    }
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        
        if self.isPasswordFieldValid == true && self.isUsernameFieldValid == true {
            
            let user = Auth.auth()
            
            user.signIn(withEmail: usernameTextFieldOutlet.text!, password: passwordTextFieldOutlet.text!) { (user, error) in
                
                if error == nil {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    var nextVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    self.present(nextVC, animated: true, completion: nil)
                    
                } else {
                    var alert = UIAlertController(title: "Error", message:String(describing: error), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)                }
            }
            
        } else {
            
          var alert = UIAlertController(title: "Fields not valid", message: "One or Both vields are not valid. Please, revise them.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "signUpViewController") as! SignUpViewController
        self.present(nextVC, animated: true, completion: nil)

}
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if self.usernameTextFieldOutlet.text?.isEmpty == true {
            self.isUsernameFieldValid = false
        } else if self.usernameTextFieldOutlet.text?.isEmpty == false {
            self.isUsernameFieldValid = true
        }
        
        if self.passwordTextFieldOutlet.text?.isEmpty == true {
            self.isPasswordFieldValid = false
        } else if self.passwordTextFieldOutlet.text?.isEmpty == false {
            self.isPasswordFieldValid = true
        }
        
    }
    
}
