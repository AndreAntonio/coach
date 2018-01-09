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
        
        let user = Auth.auth()
        
        user.signIn(withEmail: usernameTextFieldOutlet.text!, password: passwordTextFieldOutlet.text!) { (user, error) in
            
            if error == nil {
               
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                var nextVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                self.present(nextVC, animated: true, completion: nil)
                
            } else {
                print(error.debugDescription)
            }
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
    
}
