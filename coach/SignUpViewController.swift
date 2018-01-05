//
//  SignUpViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fullNameTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var confirmPasswordTextFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var textFields = [fullNameTextFieldOutlet, emailTextFieldOutlet, passwordTextFieldOutlet, confirmPasswordTextFieldOutlet]
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
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let email = self.emailTextFieldOutlet.text
        let password = self.passwordTextFieldOutlet.text
        
        let user = Auth.auth()
        user.createUser(withEmail: email!, password: password!) { (user, error) in
            if error ==  nil {
                print("Usuário está logado" +  String(describing: user?.email))
            }else{
                print("Usuário não está logado" + String(describing: error))
        }
    }
}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
